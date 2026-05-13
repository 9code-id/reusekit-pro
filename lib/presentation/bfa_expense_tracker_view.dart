import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaExpenseTrackerView extends StatefulWidget {
  const BfaExpenseTrackerView({super.key});

  @override
  State<BfaExpenseTrackerView> createState() => _BfaExpenseTrackerViewState();
}

class _BfaExpenseTrackerViewState extends State<BfaExpenseTrackerView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String selectedPeriod = "This Month";
  String searchQuery = "";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Food & Dining", "value": "Food & Dining"},
    {"label": "Transportation", "value": "Transportation"},
    {"label": "Shopping", "value": "Shopping"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Bills & Utilities", "value": "Bills & Utilities"},
    {"label": "Healthcare", "value": "Healthcare"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> expenses = [
    {
      "id": 1,
      "title": "Starbucks Coffee",
      "amount": 8.75,
      "category": "Food & Dining",
      "date": "2025-06-16",
      "time": "08:30 AM",
      "icon": Icons.local_cafe,
      "color": Colors.brown,
      "description": "Morning coffee",
      "paymentMethod": "Credit Card",
    },
    {
      "id": 2,
      "title": "Uber Ride",
      "amount": 23.50,
      "category": "Transportation",
      "date": "2025-06-16",
      "time": "09:15 AM",
      "icon": Icons.local_taxi,
      "color": Colors.blue,
      "description": "Ride to office",
      "paymentMethod": "Debit Card",
    },
    {
      "id": 3,
      "title": "Grocery Shopping",
      "amount": 87.45,
      "category": "Food & Dining",
      "date": "2025-06-15",
      "time": "06:30 PM",
      "icon": Icons.local_grocery_store,
      "color": Colors.green,
      "description": "Weekly groceries",
      "paymentMethod": "Cash",
    },
    {
      "id": 4,
      "title": "Netflix Subscription",
      "amount": 15.99,
      "category": "Entertainment",
      "date": "2025-06-15",
      "time": "12:00 PM",
      "icon": Icons.play_circle,
      "color": Colors.red,
      "description": "Monthly subscription",
      "paymentMethod": "Credit Card",
    },
    {
      "id": 5,
      "title": "Gas Station",
      "amount": 45.20,
      "category": "Transportation",
      "date": "2025-06-14",
      "time": "07:45 PM",
      "icon": Icons.local_gas_station,
      "color": Colors.orange,
      "description": "Car fuel",
      "paymentMethod": "Credit Card",
    },
    {
      "id": 6,
      "title": "Amazon Purchase",
      "amount": 156.78,
      "category": "Shopping",
      "date": "2025-06-14",
      "time": "02:20 PM",
      "icon": Icons.shopping_bag,
      "color": Colors.purple,
      "description": "Electronics",
      "paymentMethod": "Credit Card",
    },
    {
      "id": 7,
      "title": "Electric Bill",
      "amount": 89.30,
      "category": "Bills & Utilities",
      "date": "2025-06-13",
      "time": "11:00 AM",
      "icon": Icons.electrical_services,
      "color": Colors.yellow,
      "description": "Monthly electric bill",
      "paymentMethod": "Bank Transfer",
    },
    {
      "id": 8,
      "title": "Doctor Visit",
      "amount": 125.00,
      "category": "Healthcare",
      "date": "2025-06-12",
      "time": "03:00 PM",
      "icon": Icons.local_hospital,
      "color": Colors.pink,
      "description": "Consultation fee",
      "paymentMethod": "Insurance",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expense Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All", icon: Icon(Icons.list)),
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildAllExpensesTab(),
        _buildTodayTab(),
        _buildCategoriesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildAllExpensesTab() {
    List<Map<String, dynamic>> filteredExpenses = expenses.where((expense) {
      bool matchesCategory = selectedCategory == "All" || expense["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          expense["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          expense["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Add Expense Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Expense",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                // Add new expense
              },
            ),
          ),

          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search expenses...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),

          // Total Amount
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Expenses",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "\$${filteredExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double)).currency}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Expenses List
          ...filteredExpenses.map((expense) {
            return Container(
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
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (expense["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          expense["icon"] as IconData,
                          color: expense["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${expense["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${expense["category"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(expense["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "${expense["time"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (expense["description"] != null && expense["description"].toString().isNotEmpty)
                    Row(
                      children: [
                        SizedBox(width: 48),
                        Expanded(
                          child: Text(
                            "${expense["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      SizedBox(width: 48),
                      Expanded(
                        child: Text(
                          "${expense["paymentMethod"]} • ${expense["date"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Edit expense
                            },
                            child: Icon(
                              Icons.edit,
                              color: primaryColor,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              // Delete expense
                            },
                            child: Icon(
                              Icons.delete,
                              color: dangerColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTodayTab() {
    List<Map<String, dynamic>> todayExpenses = expenses.where((expense) => 
        expense["date"] == "2025-06-16").toList();

    double todayTotal = todayExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Today's Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              children: [
              Text(
                "Today's Total",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: dangerColor,
                ),
              ),
              Text(
                "\$${todayTotal.currency}",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              Text(
                "${todayExpenses.length} transactions",
                style: TextStyle(
                  color: dangerColor,
                  fontSize: 14,
                ),
              ),
              ],
            ),
          ),

          // Quick Add
          Container(
            width: double.infinity,
            child: QButton(
              label: "Quick Add Expense",
              icon: Icons.add_circle,
              size: bs.md,
              onPressed: () {
                // Quick add expense
              },
            ),
          ),

          // Today's Expenses
          if (todayExpenses.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(sp2xl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No expenses today",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Start tracking your daily expenses",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...todayExpenses.map((expense) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (expense["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        expense["icon"] as IconData,
                        color: expense["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${expense["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${expense["category"]} • ${expense["time"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(expense["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    Map<String, List<Map<String, dynamic>>> expensesByCategory = {};
    Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      String category = expense["category"];
      if (!expensesByCategory.containsKey(category)) {
        expensesByCategory[category] = [];
        categoryTotals[category] = 0.0;
      }
      expensesByCategory[category]!.add(expense);
      categoryTotals[category] = (categoryTotals[category] ?? 0.0) + (expense["amount"] as double);
    }

    List<String> sortedCategories = categoryTotals.keys.toList()
        ..sort((a, b) => (categoryTotals[b] ?? 0.0).compareTo(categoryTotals[a] ?? 0.0));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Categories Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Categories Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Total across ${sortedCategories.length} categories",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Category List
          ...sortedCategories.map((category) {
            List<Map<String, dynamic>> categoryExpenses = expensesByCategory[category]!;
            double categoryTotal = categoryTotals[category]!;
            IconData categoryIcon = categoryExpenses.first["icon"] as IconData;
            Color categoryColor = categoryExpenses.first["color"] as Color;

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: categoryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          categoryIcon,
                          color: categoryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${categoryExpenses.length} transactions",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${categoryTotal.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        // View category details
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    double totalExpenses = expenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
    double averagePerDay = totalExpenses / 7;
    
    Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      String category = expense["category"];
      categoryTotals[category] = (categoryTotals[category] ?? 0.0) + (expense["amount"] as double);
    }

    String topCategory = categoryTotals.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Overview Stats
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
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
                    Icon(
                      Icons.account_balance_wallet,
                      color: primaryColor,
                      size: 28,
                    ),
                    Text(
                      "\$${totalExpenses.currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Expenses",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
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
                    Icon(
                      Icons.timeline,
                      color: successColor,
                      size: 28,
                    ),
                    Text(
                      "\$${averagePerDay.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Daily Average",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
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
                    Icon(
                      Icons.category,
                      color: warningColor,
                      size: 28,
                    ),
                    Text(
                      topCategory,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Top Category",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
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
                    Icon(
                      Icons.receipt,
                      color: infoColor,
                      size: 28,
                    ),
                    Text(
                      "${expenses.length}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Transactions",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Spending Insights
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Spending Insights",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "• Your highest spending category is $topCategory",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                Text(
                  "• You spend an average of \$${averagePerDay.toStringAsFixed(2)} per day",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                Text(
                  "• Consider setting a budget limit for your top spending categories",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Export Data
          Container(
            width: double.infinity,
            child: QButton(
              label: "Export Expense Report",
              icon: Icons.download,
              size: bs.md,
              onPressed: () {
                // Export expense report
              },
            ),
          ),
        ],
      ),
    );
  }
}
