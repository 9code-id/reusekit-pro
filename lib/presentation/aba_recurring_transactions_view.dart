import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaRecurringTransactionsView extends StatefulWidget {
  const AbaRecurringTransactionsView({super.key});

  @override
  State<AbaRecurringTransactionsView> createState() => _AbaRecurringTransactionsViewState();
}

class _AbaRecurringTransactionsViewState extends State<AbaRecurringTransactionsView> {
  String searchQuery = "";
  String selectedFrequency = "All";
  String selectedStatus = "All";
  bool loading = false;

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "All", "value": "All"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Quarterly", "value": "Quarterly"},
    {"label": "Yearly", "value": "Yearly"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Paused", "value": "Paused"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> recurringTransactions = [
    {
      "id": "rt001",
      "name": "Monthly Office Rent",
      "description": "Office space rental payment",
      "type": "Expense",
      "account": "Bank Account - Checking",
      "accountNumber": "1002",
      "category": "Rent & Utilities",
      "amount": 2000.00,
      "frequency": "Monthly",
      "status": "Active",
      "startDate": "2024-01-01",
      "endDate": null,
      "nextDueDate": "2025-01-01",
      "lastExecuted": "2024-12-01",
      "totalExecutions": 12,
      "totalAmount": 24000.00,
      "paymentMethod": "Bank Transfer",
      "reference": "RENT-{YYYY}-{MM}",
      "autoExecute": true,
      "reminderDays": 5,
      "createdBy": "Admin",
      "createdDate": "2024-01-01"
    },
    {
      "id": "rt002",
      "name": "Quarterly Insurance Premium",
      "description": "Business insurance quarterly payment",
      "type": "Expense",
      "account": "Bank Account - Checking",
      "accountNumber": "1002",
      "category": "Insurance",
      "amount": 900.00,
      "frequency": "Quarterly",
      "status": "Active",
      "startDate": "2024-01-15",
      "endDate": "2026-01-15",
      "nextDueDate": "2025-01-15",
      "lastExecuted": "2024-10-15",
      "totalExecutions": 4,
      "totalAmount": 3600.00,
      "paymentMethod": "Credit Card",
      "reference": "INS-{YYYY}-Q{Q}",
      "autoExecute": false,
      "reminderDays": 10,
      "createdBy": "John Smith",
      "createdDate": "2024-01-15"
    },
    {
      "id": "rt003",
      "name": "Weekly Cleaning Service",
      "description": "Office cleaning service payment",
      "type": "Expense",
      "account": "Petty Cash",
      "accountNumber": "1010",
      "category": "Office Expenses",
      "amount": 150.00,
      "frequency": "Weekly",
      "status": "Active",
      "startDate": "2024-03-01",
      "endDate": null,
      "nextDueDate": "2024-12-23",
      "lastExecuted": "2024-12-16",
      "totalExecutions": 42,
      "totalAmount": 6300.00,
      "paymentMethod": "Cash",
      "reference": "CLEAN-{YYYY}-W{WW}",
      "autoExecute": true,
      "reminderDays": 1,
      "createdBy": "Sarah Wilson",
      "createdDate": "2024-03-01"
    },
    {
      "id": "rt004",
      "name": "Monthly Software Subscription",
      "description": "Accounting software monthly subscription",
      "type": "Expense",
      "account": "Credit Card",
      "accountNumber": "2100",
      "category": "Software",
      "amount": 99.00,
      "frequency": "Monthly",
      "status": "Active",
      "startDate": "2024-02-01",
      "endDate": null,
      "nextDueDate": "2025-01-01",
      "lastExecuted": "2024-12-01",
      "totalExecutions": 11,
      "totalAmount": 1089.00,
      "paymentMethod": "Credit Card",
      "reference": "SOFT-{YYYY}-{MM}",
      "autoExecute": true,
      "reminderDays": 3,
      "createdBy": "Mike Johnson",
      "createdDate": "2024-02-01"
    },
    {
      "id": "rt005",
      "name": "Annual Equipment Maintenance",
      "description": "Yearly equipment service and maintenance",
      "type": "Expense",
      "account": "Bank Account - Checking",
      "accountNumber": "1002",
      "category": "Equipment",
      "amount": 1500.00,
      "frequency": "Yearly",
      "status": "Paused",
      "startDate": "2024-06-01",
      "endDate": null,
      "nextDueDate": "2025-06-01",
      "lastExecuted": "2024-06-01",
      "totalExecutions": 1,
      "totalAmount": 1500.00,
      "paymentMethod": "Bank Transfer",
      "reference": "MAINT-{YYYY}",
      "autoExecute": false,
      "reminderDays": 30,
      "createdBy": "Jane Doe",
      "createdDate": "2024-06-01"
    },
    {
      "id": "rt006",
      "name": "Monthly Customer Subscription",
      "description": "Recurring customer subscription revenue",
      "type": "Income",
      "account": "Bank Account - Checking",
      "accountNumber": "1002",
      "category": "Subscription Revenue",
      "amount": 500.00,
      "frequency": "Monthly",
      "status": "Active",
      "startDate": "2024-04-01",
      "endDate": null,
      "nextDueDate": "2025-01-01",
      "lastExecuted": "2024-12-01",
      "totalExecutions": 9,
      "totalAmount": 4500.00,
      "paymentMethod": "Online Payment",
      "reference": "SUB-{YYYY}-{MM}",
      "autoExecute": true,
      "reminderDays": 0,
      "createdBy": "Sarah Wilson",
      "createdDate": "2024-04-01"
    },
    {
      "id": "rt007",
      "name": "Loan Repayment",
      "description": "Monthly business loan payment",
      "type": "Expense",
      "account": "Bank Account - Checking",
      "accountNumber": "1002",
      "category": "Loan Payment",
      "amount": 450.00,
      "frequency": "Monthly",
      "status": "Completed",
      "startDate": "2023-01-01",
      "endDate": "2024-12-31",
      "nextDueDate": null,
      "lastExecuted": "2024-12-01",
      "totalExecutions": 24,
      "totalAmount": 10800.00,
      "paymentMethod": "Bank Transfer",
      "reference": "LOAN-{YYYY}-{MM}",
      "autoExecute": true,
      "reminderDays": 5,
      "createdBy": "Admin",
      "createdDate": "2023-01-01"
    }
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return recurringTransactions.where((transaction) {
      bool matchesSearch = "${transaction["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${transaction["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFrequency = selectedFrequency == "All" || transaction["frequency"] == selectedFrequency;
      bool matchesStatus = selectedStatus == "All" || transaction["status"] == selectedStatus;
      return matchesSearch && matchesFrequency && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Paused":
        return warningColor;
      case "Completed":
        return infoColor;
      case "Cancelled":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Income":
        return successColor;
      case "Expense":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Active":
        return Icons.play_circle;
      case "Paused":
        return Icons.pause_circle;
      case "Completed":
        return Icons.check_circle;
      case "Cancelled":
        return Icons.cancel;
      default:
        return Icons.repeat;
    }
  }

  int get upcomingCount {
    return filteredTransactions.where((t) => t["status"] == "Active" && t["nextDueDate"] != null).length;
  }

  double get totalMonthlyAmount {
    return filteredTransactions
        .where((t) => t["status"] == "Active" && t["frequency"] == "Monthly")
        .map((t) => t["amount"] as double)
        .fold(0.0, (sum, amount) => sum + amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recurring Transactions"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo('RecurringReportsView')
            },
            icon: Icon(Icons.analytics),
          ),
          IconButton(
            onPressed: () {
              //navigateTo('AddRecurringTransactionView')
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Search and Filter Section
                  Container(
                    padding: EdgeInsets.all(spSm),
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
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Search recurring transactions...",
                                value: searchQuery,
                                hint: "Transaction name or description",
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Frequency",
                                items: frequencyOptions,
                                value: selectedFrequency,
                                onChanged: (value, label) {
                                  selectedFrequency = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: QDropdownField(
                                label: "Status",
                                items: statusOptions,
                                value: selectedStatus,
                                onChanged: (value, label) {
                                  selectedStatus = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Summary Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard(
                        "Active Transactions",
                        "${recurringTransactions.where((t) => t["status"] == "Active").length}",
                        Icons.repeat,
                        successColor,
                      ),
                      _buildSummaryCard(
                        "Upcoming This Week",
                        "$upcomingCount",
                        Icons.schedule,
                        warningColor,
                      ),
                      _buildSummaryCard(
                        "Monthly Amount",
                        "${totalMonthlyAmount.currency}",
                        Icons.calendar_month,
                        infoColor,
                      ),
                      _buildSummaryCard(
                        "Total Transactions",
                        "${recurringTransactions.length}",
                        Icons.list,
                        primaryColor,
                      ),
                    ],
                  ),

                  // Due Soon Alert
                  if (upcomingCount > 0) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: warningColor.withAlpha(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.schedule,
                              color: warningColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Transactions Due Soon",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "$upcomingCount recurring transactions need attention",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Review",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('UpcomingTransactionsView')
                            },
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Recurring Transactions List
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              Icon(
                                Icons.list,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Recurring Transactions (${filteredTransactions.length})",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredTransactions.length,
                          separatorBuilder: (context, index) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final transaction = filteredTransactions[index];
                            String status = "${transaction["status"]}";
                            String type = "${transaction["type"]}";
                            bool isActive = status == "Active";
                            bool hasNextDue = transaction["nextDueDate"] != null;

                            return GestureDetector(
                              onTap: () {
                                //navigateTo('RecurringTransactionDetailView', transaction)
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                color: !isActive ? disabledColor.withAlpha(5) : Colors.transparent,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(status).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        _getStatusIcon(status),
                                        color: _getStatusColor(status),
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${transaction["name"]}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: isActive ? primaryColor : disabledBoldColor,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spXs,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _getStatusColor(status).withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  status,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: _getStatusColor(status),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "${transaction["description"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: disabledBoldColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spXs,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _getTypeColor(type).withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  type,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: _getTypeColor(type),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Text(
                                                "${transaction["frequency"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: disabledColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Text(
                                                "${transaction["totalExecutions"]} times",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (hasNextDue && isActive) ...[
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.schedule,
                                                  color: warningColor,
                                                  size: 12,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "Next: ${DateTime.parse("${transaction["nextDueDate"]}").dMMMy}",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color: warningColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${(transaction["amount"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: _getTypeColor(type),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "Total: ${(transaction["totalAmount"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        if (transaction["autoExecute"] == true) ...[
                                          SizedBox(height: 2),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.auto_awesome,
                                                color: infoColor,
                                                size: 12,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "Auto",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: infoColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: disabledColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('AddRecurringTransactionView')
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              Spacer(),
              Icon(
                Icons.repeat,
                color: color,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
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
