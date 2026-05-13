import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment9View extends StatefulWidget {
  @override
  State<GrlPayment9View> createState() => _GrlPayment9ViewState();
}

class _GrlPayment9ViewState extends State<GrlPayment9View> {
  List<Map<String, dynamic>> expenses = [
    {
      "id": "exp_001",
      "title": "Team Lunch",
      "amount": 156.75,
      "category": "Meals & Entertainment",
      "date": "2024-06-21",
      "status": "pending",
      "receipt": "https://picsum.photos/200/300?random=1&keyword=receipt",
      "description": "Team lunch meeting with clients",
      "merchant": "The Grill Restaurant",
      "paymentMethod": "Corporate Card ****4532"
    },
    {
      "id": "exp_002",
      "title": "Business Flight",
      "amount": 845.00,
      "category": "Travel",
      "date": "2024-06-19",
      "status": "approved",
      "receipt": "https://picsum.photos/200/300?random=2&keyword=ticket",
      "description": "Flight to NYC for conference",
      "merchant": "American Airlines",
      "paymentMethod": "Personal Card ****1234"
    },
    {
      "id": "exp_003",
      "title": "Office Supplies",
      "amount": 89.50,
      "category": "Office Expenses",
      "date": "2024-06-18",
      "status": "rejected",
      "receipt": "https://picsum.photos/200/300?random=3&keyword=supplies",
      "description": "Printer paper and ink cartridges",
      "merchant": "Staples",
      "paymentMethod": "Company Account",
      "rejectionReason": "Missing itemized receipt"
    },
    {
      "id": "exp_004",
      "title": "Hotel Stay",
      "amount": 320.00,
      "category": "Accommodation",
      "date": "2024-06-17",
      "status": "reimbursed",
      "receipt": "https://picsum.photos/200/300?random=4&keyword=hotel",
      "description": "3 nights at Marriott NYC",
      "merchant": "Marriott Hotel",
      "paymentMethod": "Personal Card ****5678"
    },
    {
      "id": "exp_005",
      "title": "Taxi Fare",
      "amount": 45.25,
      "category": "Transportation",
      "date": "2024-06-16",
      "status": "approved",
      "receipt": "https://picsum.photos/200/300?random=5&keyword=taxi",
      "description": "Airport to hotel",
      "merchant": "Uber",
      "paymentMethod": "Personal Card ****1234"
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"id": "travel", "name": "Travel", "icon": Icons.flight, "color": Colors.blue},
    {"id": "meals", "name": "Meals & Entertainment", "icon": Icons.restaurant, "color": Colors.orange},
    {"id": "accommodation", "name": "Accommodation", "icon": Icons.hotel, "color": Colors.purple},
    {"id": "transportation", "name": "Transportation", "icon": Icons.directions_car, "color": Colors.green},
    {"id": "office", "name": "Office Expenses", "icon": Icons.business, "color": Colors.grey},
    {"id": "other", "name": "Other", "icon": Icons.more_horiz, "color": disabledBoldColor},
  ];

  String filterStatus = "all";
  bool showCreateExpense = false;
  String expenseTitle = "";
  String expenseAmount = "";
  String expenseCategory = "travel";
  String expenseDescription = "";
  String expenseMerchant = "";
  String receiptImage = "";
  String selectedDate = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showCreateExpense = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: showCreateExpense ? _buildCreateExpenseForm() : _buildExpensesList(),
      floatingActionButton: !showCreateExpense ? FloatingActionButton(
        onPressed: () {
          showCreateExpense = true;
          setState(() {});
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ) : null,
    );
  }

  Widget _buildExpensesList() {
    return Column(
      children: [
        _buildExpenseSummary(),
        _buildStatusFilter(),
        Expanded(
          child: _buildExpensesContent(),
        ),
      ],
    );
  }

  Widget _buildExpenseSummary() {
    double totalPending = expenses.where((exp) => exp["status"] == "pending")
        .fold(0.0, (sum, exp) => sum + (exp["amount"] as double));
    double totalApproved = expenses.where((exp) => exp["status"] == "approved")
        .fold(0.0, (sum, exp) => sum + (exp["amount"] as double));
    double totalReimbursed = expenses.where((exp) => exp["status"] == "reimbursed")
        .fold(0.0, (sum, exp) => sum + (exp["amount"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Expense Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              _buildSummaryCard("Pending", totalPending, warningColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Approved", totalApproved, successColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Reimbursed", totalReimbursed, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilter() {
    List<String> statuses = ["all", "pending", "approved", "rejected", "reimbursed"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: QHorizontalScroll(
        children: statuses.map((status) {
          bool isSelected = filterStatus == status;
          return GestureDetector(
            onTap: () {
              filterStatus = status;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                status.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? Colors.white : disabledBoldColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExpensesContent() {
    List<Map<String, dynamic>> filteredExpenses = expenses.where((expense) {
      return filterStatus == "all" || expense["status"] == filterStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: filteredExpenses.map((expense) {
          return _buildExpenseCard(expense);
        }).toList(),
      ),
    );
  }

  Widget _buildExpenseCard(Map<String, dynamic> expense) {
    Color statusColor;
    IconData statusIcon;
    
    switch (expense["status"]) {
      case "pending":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        break;
      case "approved":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "rejected":
        statusColor = dangerColor;
        statusIcon = Icons.cancel;
        break;
      case "reimbursed":
        statusColor = primaryColor;
        statusIcon = Icons.account_balance_wallet;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.help;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${expense["receipt"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${expense["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${expense["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${expense["merchant"]}",
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
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      color: statusColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${expense["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${expense["description"]}",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Row(
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
                      "\$${(expense["amount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
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
                      "Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(expense["date"]).dMMMy}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showExpenseActions(expense);
                },
              ),
            ],
          ),
          if (expense["status"] == "rejected")
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Rejection reason: ${expense["rejectionReason"] ?? "No reason provided"}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCreateExpenseForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "New Expense Report",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  showCreateExpense = false;
                  _clearForm();
                  setState(() {});
                },
              ),
            ],
          ),
          Container(
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
                Text(
                  "Expense Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QTextField(
                  label: "Expense Title",
                  value: expenseTitle,
                  hint: "Enter expense title",
                  onChanged: (value) {
                    expenseTitle = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Amount (\$)",
                  value: expenseAmount,
                  onChanged: (value) {
                    expenseAmount = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Category",
                  items: categories.map((category) => {
                    "label": category["name"],
                    "value": category["id"],
                  }).toList(),
                  value: expenseCategory,
                  onChanged: (value, label) {
                    expenseCategory = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Merchant/Vendor",
                  value: expenseMerchant,
                  hint: "Enter merchant name",
                  onChanged: (value) {
                    expenseMerchant = value;
                    setState(() {});
                  },
                ),
                QDatePicker(
                  label: "Expense Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toString();
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Description",
                  value: expenseDescription,
                  hint: "Describe the business purpose",
                  onChanged: (value) {
                    expenseDescription = value;
                    setState(() {});
                  },
                ),
                QImagePicker(
                  label: "Receipt Image",
                  value: receiptImage,
                  hint: "Upload receipt photo",
                  onChanged: (value) {
                    receiptImage = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Please ensure all expense reports comply with company policy. Receipts are required for all expenses over \$25.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  color: disabledBoldColor,
                  onPressed: _canCreateExpense() ? () {
                    _createExpense("draft");
                  } : null,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Submit for Approval",
                  onPressed: _canCreateExpense() ? () {
                    _createExpense("pending");
                  } : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _canCreateExpense() {
    return expenseTitle.isNotEmpty && 
           expenseAmount.isNotEmpty && 
           expenseMerchant.isNotEmpty &&
           expenseDescription.isNotEmpty;
  }

  void _createExpense(String status) {
    showLoading();
    
    // Simulate expense creation
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      
      String newId = "exp_${(expenses.length + 1).toString().padLeft(3, '0')}";
      Map<String, dynamic> selectedCategoryData = categories.firstWhere(
        (cat) => cat["id"] == expenseCategory,
      );
      
      expenses.insert(0, {
        "id": newId,
        "title": expenseTitle,
        "amount": double.tryParse(expenseAmount) ?? 0.0,
        "category": selectedCategoryData["name"],
        "date": selectedDate,
        "status": status,
        "receipt": receiptImage.isNotEmpty ? receiptImage : "https://picsum.photos/200/300?random=99&keyword=receipt",
        "description": expenseDescription,
        "merchant": expenseMerchant,
        "paymentMethod": "Personal Card ****1234"
      });
      
      showCreateExpense = false;
      _clearForm();
      
      if (status == "pending") {
        ss("Expense submitted for approval!");
      } else {
        ss("Expense saved as draft!");
      }
      
      setState(() {});
    });
  }

  void _clearForm() {
    expenseTitle = "";
    expenseAmount = "";
    expenseCategory = "travel";
    expenseDescription = "";
    expenseMerchant = "";
    receiptImage = "";
    selectedDate = DateTime.now().toString();
  }

  void _showExpenseActions(Map<String, dynamic> expense) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Expense Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(
                "View Receipt",
                Icons.image,
                () {
                  Navigator.pop(context);
                  si("View receipt image");
                },
              ),
              _buildActionItem(
                "Edit Expense",
                Icons.edit,
                expense["status"] == "pending" || expense["status"] == "rejected" ? () {
                  Navigator.pop(context);
                  si("Edit expense coming soon!");
                } : null,
              ),
              _buildActionItem(
                "Duplicate",
                Icons.copy,
                () {
                  Navigator.pop(context);
                  si("Duplicate expense coming soon!");
                },
              ),
              _buildActionItem(
                "Download PDF",
                Icons.download,
                () {
                  Navigator.pop(context);
                  si("Downloading PDF...");
                },
              ),
              _buildActionItem(
                "Delete Expense",
                Icons.delete,
                expense["status"] == "pending" ? () {
                  Navigator.pop(context);
                  _deleteExpense(expense);
                } : null,
                color: dangerColor,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(String title, IconData icon, VoidCallback? onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spMd),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? (onTap != null ? primaryColor : disabledBoldColor),
            ),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                color: color ?? (onTap != null ? Colors.black : disabledBoldColor),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteExpense(Map<String, dynamic> expense) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this expense?");
    if (isConfirmed) {
      expenses.removeWhere((exp) => exp["id"] == expense["id"]);
      ss("Expense deleted successfully!");
      setState(() {});
    }
  }
}
