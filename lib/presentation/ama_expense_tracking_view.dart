import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaExpenseTrackingView extends StatefulWidget {
  const AmaExpenseTrackingView({super.key});

  @override
  State<AmaExpenseTrackingView> createState() => _AmaExpenseTrackingViewState();
}

class _AmaExpenseTrackingViewState extends State<AmaExpenseTrackingView> {
  String selectedCategory = "All";
  String selectedPeriod = "This Month";
  String expenseTitle = "";
  String expenseAmount = "";
  String expenseCategory = "Seeds";
  String expenseDescription = "";
  DateTime selectedDate = DateTime.now();
  String paymentMethod = "Cash";
  String supplier = "";
  
  bool showAddExpense = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Seeds", "value": "Seeds"},
    {"label": "Fertilizer", "value": "Fertilizer"},
    {"label": "Pesticides", "value": "Pesticides"},
    {"label": "Labor", "value": "Labor"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Fuel", "value": "Fuel"},
    {"label": "Irrigation", "value": "Irrigation"},
    {"label": "Transport", "value": "Transport"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Insurance", "value": "Insurance"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> paymentOptions = [
    {"label": "Cash", "value": "Cash"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Check", "value": "Check"},
    {"label": "Mobile Payment", "value": "Mobile Payment"},
  ];

  List<Map<String, dynamic>> expenses = [
    {
      "title": "Corn Seeds",
      "amount": 850.00,
      "category": "Seeds",
      "date": "2024-06-14",
      "supplier": "AgriSeed Co.",
      "paymentMethod": "Bank Transfer",
      "description": "Premium corn seeds for 20 acres",
      "receipt": true,
    },
    {
      "title": "NPK Fertilizer",
      "amount": 1200.00,
      "category": "Fertilizer",
      "date": "2024-06-13",
      "supplier": "Farm Supply Inc.",
      "paymentMethod": "Credit Card",
      "description": "NPK 15-15-15 fertilizer - 10 bags",
      "receipt": true,
    },
    {
      "title": "Tractor Fuel",
      "amount": 180.50,
      "category": "Fuel",
      "date": "2024-06-12",
      "supplier": "Local Gas Station",
      "paymentMethod": "Cash",
      "description": "Diesel fuel for tractor operations",
      "receipt": false,
    },
    {
      "title": "Field Labor",
      "amount": 480.00,
      "category": "Labor",
      "date": "2024-06-11",
      "supplier": "Local Workers",
      "paymentMethod": "Cash",
      "description": "4 workers for planting - 8 hours each",
      "receipt": false,
    },
    {
      "title": "Pesticide Spray",
      "amount": 320.00,
      "category": "Pesticides",
      "date": "2024-06-10",
      "supplier": "Crop Protection Ltd.",
      "paymentMethod": "Bank Transfer",
      "description": "Herbicide for weed control",
      "receipt": true,
    },
    {
      "title": "Irrigation System Repair",
      "amount": 650.00,
      "category": "Equipment",
      "date": "2024-06-09",
      "supplier": "IrriTech Services",
      "paymentMethod": "Check",
      "description": "Repair of sprinkler system",
      "receipt": true,
    },
  ];

  List<Map<String, dynamic>> expenseCategories = [
    {
      "name": "Seeds",
      "amount": 850.00,
      "percentage": 18.5,
      "color": Colors.green,
      "icon": Icons.eco,
    },
    {
      "name": "Fertilizer",
      "amount": 1200.00,
      "percentage": 26.1,
      "color": Colors.brown,
      "icon": Icons.grass,
    },
    {
      "name": "Labor",
      "amount": 480.00,
      "percentage": 10.4,
      "color": Colors.blue,
      "icon": Icons.people,
    },
    {
      "name": "Fuel",
      "amount": 180.50,
      "percentage": 3.9,
      "color": Colors.orange,
      "icon": Icons.local_gas_station,
    },
    {
      "name": "Pesticides",
      "amount": 320.00,
      "percentage": 7.0,
      "color": Colors.red,
      "icon": Icons.bug_report,
    },
    {
      "name": "Equipment",
      "amount": 650.00,
      "percentage": 14.1,
      "color": Colors.purple,
      "icon": Icons.build,
    },
    {
      "name": "Other",
      "amount": 920.00,
      "percentage": 20.0,
      "color": Colors.grey,
      "icon": Icons.more_horiz,
    },
  ];

  double get totalExpenses => expenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  double get monthlyBudget => 5000.0;
  double get budgetUsed => (totalExpenses / monthlyBudget) * 100;

  void _addExpense() {
    if (expenseTitle.isNotEmpty && expenseAmount.isNotEmpty) {
      Map<String, dynamic> newExpense = {
        "title": expenseTitle,
        "amount": double.tryParse(expenseAmount) ?? 0.0,
        "category": expenseCategory,
        "date": selectedDate.toString().split(' ')[0],
        "supplier": supplier,
        "paymentMethod": paymentMethod,
        "description": expenseDescription,
        "receipt": false,
      };
      
      expenses.insert(0, newExpense);
      
      // Reset form
      expenseTitle = "";
      expenseAmount = "";
      expenseDescription = "";
      supplier = "";
      showAddExpense = false;
      
      setState(() {});
      ss("Expense added successfully");
    } else {
      se("Please fill in required fields");
    }
  }

  List<Map<String, dynamic>> get filteredExpenses {
    if (selectedCategory == "All") {
      return expenses;
    }
    return expenses.where((expense) => expense["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              //navigateTo('AmaExpenseFilterView')
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Expense report exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Budget Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(128)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monthly Budget",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(204),
                        ),
                      ),
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${monthlyBudget.currency}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Used: \$${totalExpenses.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(204),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "(${budgetUsed.toStringAsFixed(1)}%)",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: budgetUsed > 90 ? dangerColor : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(102),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (budgetUsed / 100).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: budgetUsed > 90 ? dangerColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.all(spSm),
              minItemWidth: 200,
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
                    children: [
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "This Month",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${totalExpenses.currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "+12% from last month",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
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
                    children: [
                      Row(
                        children: [
                          Icon(Icons.receipt_long, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Transactions",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${expenses.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "6 this week",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    children: [
                      Row(
                        children: [
                          Icon(Icons.category, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Top Category",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Fertilizer",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "26.1% of total",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filters
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

            // Add Expense Button
            if (!showAddExpense)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add New Expense",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    showAddExpense = true;
                    setState(() {});
                  },
                ),
              ),

            // Add Expense Form
            if (showAddExpense) ...[
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add New Expense",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAddExpense = false;
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Expense Title",
                      value: expenseTitle,
                      hint: "e.g. Fertilizer Purchase",
                      onChanged: (value) {
                        expenseTitle = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Amount (\$)",
                            value: expenseAmount,
                            onChanged: (value) {
                              expenseAmount = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categoryOptions.where((item) => item["value"] != "All").toList(),
                            value: expenseCategory,
                            onChanged: (value, label) {
                              expenseCategory = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Date",
                            value: selectedDate,
                            onChanged: (value) {
                              selectedDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Payment Method",
                            items: paymentOptions,
                            value: paymentMethod,
                            onChanged: (value, label) {
                              paymentMethod = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Supplier",
                      value: supplier,
                      hint: "Supplier name",
                      onChanged: (value) {
                        supplier = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: expenseDescription,
                      hint: "Additional details about the expense",
                      onChanged: (value) {
                        expenseDescription = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            onPressed: () {
                              showAddExpense = false;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Add Expense",
                            onPressed: _addExpense,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Expense Categories Overview
            Text(
              "Expense Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
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
                spacing: spSm,
                children: expenseCategories.map((category) {
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          color: category["color"] as Color,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: ((category["percentage"] as double) / 100).clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: category["color"] as Color,
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
                            "\$${((category["amount"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${(category["percentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Recent Expenses
            Text(
              "Recent Expenses",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
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
                spacing: spSm,
                children: filteredExpenses.map((expense) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.receipt,
                                color: primaryColor,
                                size: 16,
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${expense["category"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${expense["date"]}",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${((expense["amount"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${expense["paymentMethod"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (expense["description"] != null && (expense["description"] as String).isNotEmpty) ...[
                          SizedBox(height: spXs),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${expense["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                        if (expense["supplier"] != null && (expense["supplier"] as String).isNotEmpty) ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.store, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Text(
                                "Supplier: ${expense["supplier"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              if (expense["receipt"] as bool)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Receipt",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
