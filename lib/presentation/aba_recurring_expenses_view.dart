import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaRecurringExpensesView extends StatefulWidget {
  const AbaRecurringExpensesView({super.key});

  @override
  State<AbaRecurringExpensesView> createState() => _AbaRecurringExpensesViewState();
}

class _AbaRecurringExpensesViewState extends State<AbaRecurringExpensesView> {
  int selectedTabIndex = 0;
  
  // Add/Edit Recurring Expense Form
  String expenseTitle = "";
  String description = "";
  String category = "Office Supplies";
  String frequency = "Monthly";
  double amount = 0.0;
  String startDate = DateTime.now().toString().split(' ')[0];
  String vendor = "";
  bool isActive = true;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Office Supplies", "value": "Office Supplies"},
    {"label": "Software & Licenses", "value": "Software & Licenses"},
    {"label": "Utilities", "value": "Utilities"},
    {"label": "Insurance", "value": "Insurance"},
    {"label": "Rent & Lease", "value": "Rent & Lease"},
    {"label": "Subscriptions", "value": "Subscriptions"},
    {"label": "Maintenance", "value": "Maintenance"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Quarterly", "value": "Quarterly"},
    {"label": "Annually", "value": "Annually"},
  ];

  List<Map<String, dynamic>> recurringExpenses = [
    {
      "id": 1,
      "title": "Office Software License",
      "description": "Microsoft Office 365 Business Premium",
      "category": "Software & Licenses",
      "frequency": "Monthly",
      "amount": 299.99,
      "vendor": "Microsoft Corporation",
      "startDate": "2024-01-01",
      "nextDue": "2024-04-01",
      "status": "Active",
      "totalPaid": 899.97,
      "paymentHistory": [
        {"date": "2024-03-01", "amount": 299.99, "status": "Paid"},
        {"date": "2024-02-01", "amount": 299.99, "status": "Paid"},
        {"date": "2024-01-01", "amount": 299.99, "status": "Paid"}
      ]
    },
    {
      "id": 2,
      "title": "Office Rent",
      "description": "Monthly office space rental",
      "category": "Rent & Lease",
      "frequency": "Monthly",
      "amount": 3500.00,
      "vendor": "Prime Properties LLC",
      "startDate": "2023-06-01",
      "nextDue": "2024-04-01",
      "status": "Active",
      "totalPaid": 31500.00,
      "paymentHistory": [
        {"date": "2024-03-01", "amount": 3500.00, "status": "Paid"},
        {"date": "2024-02-01", "amount": 3500.00, "status": "Paid"},
        {"date": "2024-01-01", "amount": 3500.00, "status": "Paid"}
      ]
    },
    {
      "id": 3,
      "title": "Internet & Phone Service",
      "description": "Business internet and phone lines",
      "category": "Utilities",
      "frequency": "Monthly",
      "amount": 189.99,
      "vendor": "TelecomPlus Business",
      "startDate": "2023-05-15",
      "nextDue": "2024-04-15",
      "status": "Active",
      "totalPaid": 2089.89,
      "paymentHistory": [
        {"date": "2024-03-15", "amount": 189.99, "status": "Paid"},
        {"date": "2024-02-15", "amount": 189.99, "status": "Paid"},
        {"date": "2024-01-15", "amount": 189.99, "status": "Paid"}
      ]
    },
    {
      "id": 4,
      "title": "Cloud Storage Service",
      "description": "Business cloud storage and backup",
      "category": "Software & Licenses",
      "frequency": "Annually",
      "amount": 1200.00,
      "vendor": "CloudSafe Enterprise",
      "startDate": "2024-01-01",
      "nextDue": "2025-01-01",
      "status": "Active",
      "totalPaid": 1200.00,
      "paymentHistory": [
        {"date": "2024-01-01", "amount": 1200.00, "status": "Paid"}
      ]
    },
    {
      "id": 5,
      "title": "Equipment Maintenance",
      "description": "Quarterly equipment maintenance contract",
      "category": "Maintenance",
      "frequency": "Quarterly",
      "amount": 750.00,
      "vendor": "TechService Pro",
      "startDate": "2024-01-01",
      "nextDue": "2024-04-01",
      "status": "Paused",
      "totalPaid": 750.00,
      "paymentHistory": [
        {"date": "2024-01-01", "amount": 750.00, "status": "Paid"}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Recurring Expenses",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.repeat)),
        Tab(text: "Add New", icon: Icon(Icons.add_circle)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildActiveTab(),
        _buildAddNewTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activeExpenses = recurringExpenses.where((expense) => expense["status"] == "Active").toList();
    List<Map<String, dynamic>> pausedExpenses = recurringExpenses.where((expense) => expense["status"] == "Paused").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active Expenses",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${activeExpenses.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Monthly Total",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${_calculateMonthlyTotal().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Due",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${_getNextDueCount()}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (activeExpenses.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.repeat, color: successColor, size: 20),
                  SizedBox(width: spXs),
                  Text(
                    "Active Recurring Expenses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
            ...activeExpenses.map((expense) => _buildRecurringExpenseCard(expense)),
          ],
          if (pausedExpenses.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.pause_circle, color: warningColor, size: 20),
                  SizedBox(width: spXs),
                  Text(
                    "Paused Expenses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
            ...pausedExpenses.map((expense) => _buildRecurringExpenseCard(expense)),
          ],
        ],
      ),
    );
  }

  Widget _buildRecurringExpenseCard(Map<String, dynamic> expense) {
    Color statusColor = expense["status"] == "Active" ? successColor : warningColor;
    bool isDueSoon = _isDueSoon(expense["nextDue"]);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isDueSoon ? dangerColor : statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${expense["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${expense["vendor"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${expense["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${expense["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(expense["amount"] as num).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                        "Frequency",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${expense["frequency"]}",
                        style: TextStyle(
                          fontSize: 16,
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
                        "Next Due",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${expense["nextDue"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDueSoon ? dangerColor : primaryColor,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${expense["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Total Paid: \$${(expense["totalPaid"] as num).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (isDueSoon)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: dangerColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Payment due soon!",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View History",
                  size: bs.sm,
                  onPressed: () {
                    _showPaymentHistory(expense);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {
                    si("Edit recurring expense");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: expense["status"] == "Active" ? "Pause" : "Resume",
                  size: bs.sm,
                  onPressed: () async {
                    String action = expense["status"] == "Active" ? "pause" : "resume";
                    bool isConfirmed = await confirm("$action this recurring expense?");
                    if (isConfirmed) {
                      ss("Recurring expense ${action}d successfully");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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
                Row(
                  children: [
                    Icon(Icons.add_business, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Add Recurring Expense",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Expense Title",
                  value: expenseTitle,
                  hint: "e.g., Office Software License",
                  onChanged: (value) {
                    expenseTitle = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Description",
                  value: description,
                  hint: "Detailed description of the recurring expense",
                  onChanged: (value) {
                    description = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: category,
                        onChanged: (value, label) {
                          category = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Frequency",
                        items: frequencyOptions,
                        value: frequency,
                        onChanged: (value, label) {
                          frequency = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Amount (\$)",
                        value: amount.toString(),
                        onChanged: (value) {
                          amount = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDatePicker(
                        label: "Start Date",
                        value: DateTime.parse(startDate),
                        onChanged: (value) {
                          startDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Vendor/Payee",
                  value: vendor,
                  hint: "Company or person receiving payment",
                  onChanged: (value) {
                    vendor = value;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Start Active",
                      "value": true,
                      "checked": isActive,
                    }
                  ],
                  value: [if (isActive) {"label": "Start Active", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isActive = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Expense Preview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                if (expenseTitle.isNotEmpty) ...[
                  Text(
                    "Title: $expenseTitle",
                    style: TextStyle(fontSize: 14, color: primaryColor),
                  ),
                ],
                if (amount > 0) ...[
                  Text(
                    "Amount: \$${amount.toStringAsFixed(2)} ($frequency)",
                    style: TextStyle(fontSize: 14, color: primaryColor),
                  ),
                  Text(
                    "Monthly Equivalent: \$${_calculateMonthlyEquivalent(amount, frequency).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 14, color: successColor),
                  ),
                  Text(
                    "Annual Equivalent: \$${(_calculateMonthlyEquivalent(amount, frequency) * 12).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 14, color: warningColor),
                  ),
                ],
                if (vendor.isNotEmpty) ...[
                  Text(
                    "Vendor: $vendor",
                    style: TextStyle(fontSize: 14, color: primaryColor),
                  ),
                ],
              ],
            ),
          ),
          QButton(
            label: "Create Recurring Expense",
            onPressed: () {
              if (expenseTitle.isNotEmpty && amount > 0 && vendor.isNotEmpty) {
                ss("Recurring expense created successfully");
                // Reset form
                expenseTitle = "";
                description = "";
                amount = 0.0;
                vendor = "";
                setState(() {});
              } else {
                se("Please fill in all required fields");
              }
            },
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
                  "Spending Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.calendar_month, color: primaryColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Monthly",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${_calculateMonthlyTotal().toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.calendar_today, color: successColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Annual",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(_calculateMonthlyTotal() * 12).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                Text(
                  "Category Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildCategoryBreakdown("Software & Licenses", 1499.99, 35, primaryColor),
                _buildCategoryBreakdown("Rent & Lease", 3500.00, 30, successColor),
                _buildCategoryBreakdown("Utilities", 189.99, 20, warningColor),
                _buildCategoryBreakdown("Maintenance", 750.00, 15, infoColor),
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
                Text(
                  "Frequency Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildFrequencyDistribution("Monthly", 3, 60, primaryColor),
                _buildFrequencyDistribution("Quarterly", 1, 20, successColor),
                _buildFrequencyDistribution("Annually", 1, 20, warningColor),
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
                Text(
                  "Upcoming Payments (Next 30 Days)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ..._getUpcomingPayments().map((payment) => _buildUpcomingPaymentRow(payment)),
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
                Text(
                  "Cost Savings Opportunities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSavingsOpportunity(
                  "Review Annual Subscriptions",
                  "Consider switching to annual billing for 15% savings",
                  "Potential savings: \$540/year",
                  successColor
                ),
                _buildSavingsOpportunity(
                  "Consolidate Software Licenses",
                  "Some overlapping features across multiple tools",
                  "Potential savings: \$200/month",
                  warningColor
                ),
                _buildSavingsOpportunity(
                  "Negotiate Utility Rates",
                  "Review current rates with service providers",
                  "Potential savings: \$50/month",
                  infoColor
                ),
              ],
            ),
          ),
          QButton(
            label: "Export Analytics Report",
            onPressed: () {
              ss("Analytics report exported successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown(String category, double amount, int percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                "$percentage%",
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

  Widget _buildFrequencyDistribution(String frequency, int count, int percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            frequency == "Monthly" ? Icons.calendar_month : 
            frequency == "Quarterly" ? Icons.date_range : Icons.calendar_today,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  frequency,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "$count ($percentage%)",
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

  Widget _buildUpcomingPaymentRow(Map<String, dynamic> payment) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule, color: warningColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${payment["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Due: ${payment["dueDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${(payment["amount"] as num).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: warningColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsOpportunity(String title, String description, String savings, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  savings,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentHistory(Map<String, dynamic> expense) {
    // Implementation for showing payment history modal/dialog
    si("Showing payment history for ${expense["title"]}");
  }

  double _calculateMonthlyTotal() {
    double total = 0.0;
    for (var expense in recurringExpenses.where((e) => e["status"] == "Active")) {
      total += _calculateMonthlyEquivalent(expense["amount"] as double, expense["frequency"] as String);
    }
    return total;
  }

  double _calculateMonthlyEquivalent(double amount, String frequency) {
    switch (frequency) {
      case "Weekly":
        return amount * 4.35; // Average weeks per month
      case "Monthly":
        return amount;
      case "Quarterly":
        return amount / 3;
      case "Annually":
        return amount / 12;
      default:
        return amount;
    }
  }

  int _getNextDueCount() {
    DateTime now = DateTime.now();
    DateTime nextWeek = now.add(Duration(days: 7));
    
    return recurringExpenses.where((expense) => 
      expense["status"] == "Active" && 
      DateTime.parse(expense["nextDue"]).isBefore(nextWeek)
    ).length;
  }

  bool _isDueSoon(String dueDate) {
    DateTime now = DateTime.now();
    DateTime due = DateTime.parse(dueDate);
    return due.difference(now).inDays <= 7;
  }

  List<Map<String, dynamic>> _getUpcomingPayments() {
    DateTime now = DateTime.now();
    DateTime thirtyDaysFromNow = now.add(Duration(days: 30));
    
    return recurringExpenses.where((expense) => 
      expense["status"] == "Active" && 
      DateTime.parse(expense["nextDue"]).isBefore(thirtyDaysFromNow)
    ).map((expense) => {
      "title": expense["title"],
      "amount": expense["amount"],
      "dueDate": expense["nextDue"]
    }).toList();
  }
}
