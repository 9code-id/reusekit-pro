import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaExpenseTrackingView extends StatefulWidget {
  const FmaExpenseTrackingView({super.key});

  @override
  State<FmaExpenseTrackingView> createState() => _FmaExpenseTrackingViewState();
}

class _FmaExpenseTrackingViewState extends State<FmaExpenseTrackingView> {
  List<Map<String, dynamic>> expenses = [
    {
      "id": "EXP001",
      "date": "2024-06-15",
      "merchant": "Office Depot",
      "description": "Office supplies and stationery",
      "category": "Office Supplies",
      "amount": 245.67,
      "paymentMethod": "Business Credit Card",
      "receipt": true,
      "status": "Approved",
      "tags": ["office", "supplies", "tax-deductible"],
    },
    {
      "id": "EXP002",
      "date": "2024-06-14",
      "merchant": "Starbucks",
      "description": "Client meeting coffee",
      "category": "Meals & Entertainment",
      "amount": 28.50,
      "paymentMethod": "Business Credit Card",
      "receipt": true,
      "status": "Pending",
      "tags": ["client", "meeting", "food"],
    },
    {
      "id": "EXP003",
      "date": "2024-06-13",
      "merchant": "Uber",
      "description": "Airport transportation",
      "category": "Travel",
      "amount": 45.00,
      "paymentMethod": "Business Checking",
      "receipt": false,
      "status": "Approved",
      "tags": ["travel", "airport", "transportation"],
    },
    {
      "id": "EXP004",
      "date": "2024-06-12",
      "merchant": "Amazon Web Services",
      "description": "Cloud hosting services",
      "category": "Software & Technology",
      "amount": 156.89,
      "paymentMethod": "Business Credit Card",
      "receipt": true,
      "status": "Approved",
      "tags": ["technology", "hosting", "monthly"],
    },
    {
      "id": "EXP005",
      "date": "2024-06-11",
      "merchant": "FedEx",
      "description": "Package shipping",
      "category": "Shipping & Logistics",
      "amount": 23.45,
      "paymentMethod": "Business Credit Card",
      "receipt": true,
      "status": "Rejected",
      "tags": ["shipping", "client"],
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "Office Supplies", "budget": 500.0, "spent": 245.67},
    {"name": "Meals & Entertainment", "budget": 300.0, "spent": 128.50},
    {"name": "Travel", "budget": 1000.0, "spent": 445.00},
    {"name": "Software & Technology", "budget": 800.0, "spent": 756.89},
    {"name": "Shipping & Logistics", "budget": 200.0, "spent": 123.45},
    {"name": "Marketing", "budget": 600.0, "spent": 287.30},
  ];

  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  String selectedStatus = "All";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Office Supplies", "value": "Office Supplies"},
    {"label": "Meals & Entertainment", "value": "Meals & Entertainment"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Software & Technology", "value": "Software & Technology"},
    {"label": "Shipping & Logistics", "value": "Shipping & Logistics"},
    {"label": "Marketing", "value": "Marketing"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Rejected", "value": "Rejected"},
  ];

  @override
  Widget build(BuildContext context) {
    double totalExpenses = expenses.fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double approvedExpenses = expenses
        .where((exp) => exp["status"] == "Approved")
        .fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double pendingExpenses = expenses
        .where((exp) => exp["status"] == "Pending")
        .fold(0.0, (sum, item) => sum + (item["amount"] as double));
    int expensesWithReceipts = expenses.where((exp) => exp["receipt"] == true).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add new expense feature");
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Expense report exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Column(
              spacing: spMd,
              children: [
                Row(
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
                    SizedBox(width: spMd),
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
                  ],
                ),
                QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Total Expenses",
                  "\$${totalExpenses.currency}",
                  Icons.receipt_long,
                  primaryColor,
                ),
                _buildSummaryCard(
                  "Approved",
                  "\$${approvedExpenses.currency}",
                  Icons.check_circle,
                  successColor,
                ),
                _buildSummaryCard(
                  "Pending",
                  "\$${pendingExpenses.currency}",
                  Icons.schedule,
                  warningColor,
                ),
                _buildSummaryCard(
                  "With Receipts",
                  "${expensesWithReceipts}/${expenses.length}",
                  Icons.receipt,
                  infoColor,
                ),
              ],
            ),

            // Category Budget Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.category, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Category Budget",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Set Budgets",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: categories.map((category) {
                      double budgetUsed = (category["spent"] as double) / (category["budget"] as double);
                      Color progressColor = budgetUsed > 1.0
                          ? dangerColor
                          : budgetUsed > 0.8
                              ? warningColor
                              : successColor;

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${category["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${(category["spent"] as double).currency} / \$${(category["budget"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: budgetUsed > 1.0 ? 1.0 : budgetUsed,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: progressColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(budgetUsed * 100).toStringAsFixed(0)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: progressColor,
                                  ),
                                ),
                              ],
                            ),
                            if (budgetUsed > 0.8)
                              Row(
                                children: [
                                  Icon(
                                    budgetUsed > 1.0 ? Icons.warning : Icons.info,
                                    color: progressColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    budgetUsed > 1.0
                                        ? "Budget exceeded by \$${((category["spent"] as double) - (category["budget"] as double)).toStringAsFixed(2)}"
                                        : "Approaching budget limit",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: progressColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Expense List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Expenses",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Expense",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: expenses.map((expense) {
                      Color statusColor = expense["status"] == "Approved"
                          ? successColor
                          : expense["status"] == "Rejected"
                              ? dangerColor
                              : warningColor;

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                  ),
                                  child: Icon(
                                    expense["status"] == "Approved"
                                        ? Icons.check_circle
                                        : expense["status"] == "Rejected"
                                            ? Icons.cancel
                                            : Icons.schedule,
                                    color: statusColor,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${expense["merchant"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${expense["description"]}",
                                        style: TextStyle(
                                          fontSize: 14,
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
                                      "\$${(expense["amount"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: statusColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${expense["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: statusColor,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                        "Category",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${expense["category"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "Date",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${DateTime.parse(expense["date"]).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "Payment",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${expense["paymentMethod"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                if (expense["receipt"] == true)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.receipt, color: successColor, size: 12),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Receipt",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Wrap(
                                    spacing: spXs,
                                    children: ((expense["tags"] as List).take(2)).map((tag) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "$tag",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: infoColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                QButton(
                                  label: "Edit",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spMd),
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
