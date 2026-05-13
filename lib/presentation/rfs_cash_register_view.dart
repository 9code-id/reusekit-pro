import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsCashRegisterView extends StatefulWidget {
  const RfsCashRegisterView({super.key});

  @override
  State<RfsCashRegisterView> createState() => _RfsCashRegisterViewState();
}

class _RfsCashRegisterViewState extends State<RfsCashRegisterView> {
  int currentTab = 0;
  String currentShift = "Day Shift";
  double openingBalance = 500.00;
  double currentBalance = 2845.75;
  double cashSales = 1567.40;
  double cashTips = 234.50;
  double cashRefunds = 45.20;
  double cashDrawerCount = 2756.70;
  String transactionType = "Sale";
  String transactionAmount = "";
  String transactionDescription = "";
  String selectedRegister = "Register 1";
  String employeeName = "John Smith";

  List<Map<String, dynamic>> registerOptions = [
    {"label": "Register 1 - Main Counter", "value": "Register 1"},
    {"label": "Register 2 - Bar Area", "value": "Register 2"},
    {"label": "Register 3 - Take Away", "value": "Register 3"},
    {"label": "Register 4 - Drive Through", "value": "Register 4"},
  ];

  List<Map<String, dynamic>> transactionTypeOptions = [
    {"label": "Sale", "value": "Sale"},
    {"label": "Refund", "value": "Refund"},
    {"label": "Cash In", "value": "Cash In"},
    {"label": "Cash Out", "value": "Cash Out"},
    {"label": "Tips", "value": "Tips"},
    {"label": "Petty Cash", "value": "Petty Cash"},
  ];

  List<Map<String, dynamic>> cashTransactions = [
    {
      "id": "CSH-2024-0456",
      "type": "Sale",
      "amount": 67.50,
      "description": "Table 8 - Cash Payment",
      "time": "19:45",
      "employee": "John Smith",
      "register": "Register 1",
      "table": "Table 8",
      "receipt": "RCP-789456"
    },
    {
      "id": "CSH-2024-0457",
      "type": "Tips",
      "amount": 15.00,
      "description": "Tips for Table 5",
      "time": "19:30",
      "employee": "Sarah Johnson",
      "register": "Register 1",
      "table": "Table 5",
      "receipt": null
    },
    {
      "id": "CSH-2024-0458",
      "type": "Cash Out",
      "amount": -25.00,
      "description": "Change for customer",
      "time": "19:20",
      "employee": "Mike Davis",
      "register": "Register 2",
      "table": null,
      "receipt": null
    },
    {
      "id": "CSH-2024-0459",
      "type": "Sale",
      "amount": 123.40,
      "description": "Table 12 - Group order",
      "time": "19:10",
      "employee": "Emma Wilson",
      "register": "Register 1",
      "table": "Table 12",
      "receipt": "RCP-789457"
    },
    {
      "id": "CSH-2024-0460",
      "type": "Refund",
      "amount": -18.75,
      "description": "Order cancellation - Table 3",
      "time": "18:55",
      "employee": "John Smith",
      "register": "Register 1",
      "table": "Table 3",
      "receipt": "RCP-789458"
    }
  ];

  List<Map<String, dynamic>> registerStats = [
    {
      "register": "Register 1",
      "location": "Main Counter",
      "status": "Active",
      "employee": "John Smith",
      "openingBalance": 500.00,
      "currentBalance": 2845.75,
      "totalSales": 1567.40,
      "totalTips": 234.50,
      "transactions": 45,
      "lastTransaction": "19:45",
      "shiftStart": "08:00"
    },
    {
      "register": "Register 2",
      "location": "Bar Area",
      "status": "Active",
      "employee": "Sarah Johnson",
      "openingBalance": 300.00,
      "currentBalance": 1456.20,
      "totalSales": 987.60,
      "totalTips": 168.60,
      "transactions": 32,
      "lastTransaction": "19:40",
      "shiftStart": "08:00"
    },
    {
      "register": "Register 3",
      "location": "Take Away",
      "status": "Active",
      "employee": "Mike Davis",
      "openingBalance": 200.00,
      "currentBalance": 876.45,
      "totalSales": 567.80,
      "totalTips": 108.65,
      "transactions": 28,
      "lastTransaction": "19:35",
      "shiftStart": "12:00"
    },
    {
      "register": "Register 4",
      "location": "Drive Through",
      "status": "Inactive",
      "employee": null,
      "openingBalance": 150.00,
      "currentBalance": 150.00,
      "totalSales": 0.00,
      "totalTips": 0.00,
      "transactions": 0,
      "lastTransaction": null,
      "shiftStart": null
    }
  ];

  List<Map<String, dynamic>> shiftReports = [
    {
      "date": "2024-01-15",
      "shift": "Day Shift",
      "employee": "John Smith",
      "register": "Register 1",
      "startTime": "08:00",
      "endTime": "16:00",
      "openingBalance": 500.00,
      "closingBalance": 2234.50,
      "totalSales": 1734.50,
      "totalTips": 278.30,
      "totalRefunds": 23.50,
      "cashDrawerCount": 2245.80,
      "variance": 11.30,
      "status": "Completed"
    },
    {
      "date": "2024-01-15",
      "shift": "Evening Shift",
      "employee": "Sarah Johnson",
      "register": "Register 2",
      "startTime": "16:00",
      "endTime": "22:00",
      "openingBalance": 300.00,
      "closingBalance": 1567.80,
      "totalSales": 1267.80,
      "totalTips": 198.45,
      "totalRefunds": 12.75,
      "cashDrawerCount": 1575.20,
      "variance": 7.40,
      "status": "Completed"
    },
    {
      "date": "2024-01-14",
      "shift": "Day Shift",
      "employee": "Mike Davis",
      "register": "Register 1",
      "startTime": "08:00",
      "endTime": "16:00",
      "openingBalance": 500.00,
      "closingBalance": 1987.60,
      "totalSales": 1487.60,
      "totalTips": 234.80,
      "totalRefunds": 34.20,
      "cashDrawerCount": 1978.90,
      "variance": -8.70,
      "status": "Completed"
    },
    {
      "date": "2024-01-14",
      "shift": "Evening Shift",
      "employee": "Emma Wilson",
      "register": "Register 2",
      "startTime": "16:00",
      "endTime": "22:00",
      "openingBalance": 300.00,
      "closingBalance": 1345.90,
      "totalSales": 1045.90,
      "totalTips": 167.30,
      "totalRefunds": 18.40,
      "cashDrawerCount": 1352.60,
      "variance": 6.70,
      "status": "Completed"
    }
  ];

  List<Map<String, dynamic>> denominationCounts = [
    {"denomination": "\$100", "count": 15, "total": 1500.00, "type": "bill"},
    {"denomination": "\$50", "count": 8, "total": 400.00, "type": "bill"},
    {"denomination": "\$20", "count": 25, "total": 500.00, "type": "bill"},
    {"denomination": "\$10", "count": 18, "total": 180.00, "type": "bill"},
    {"denomination": "\$5", "count": 22, "total": 110.00, "type": "bill"},
    {"denomination": "\$1", "count": 45, "total": 45.00, "type": "bill"},
    {"denomination": "\$1.00", "count": 28, "total": 28.00, "type": "coin"},
    {"denomination": "\$0.25", "count": 120, "total": 30.00, "type": "coin"},
    {"denomination": "\$0.10", "count": 85, "total": 8.50, "type": "coin"},
    {"denomination": "\$0.05", "count": 60, "total": 3.00, "type": "coin"},
    {"denomination": "\$0.01", "count": 125, "total": 1.25, "type": "coin"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Cash Register",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Current Shift", icon: Icon(Icons.point_of_sale)),
        Tab(text: "Transactions", icon: Icon(Icons.receipt_long)),
        Tab(text: "All Registers", icon: Icon(Icons.store)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildCurrentShiftTab(),
        _buildTransactionsTab(),
        _buildAllRegistersTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildCurrentShiftTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildShiftHeader(),
          _buildCashBalance(),
          _buildQuickActions(),
          _buildCashCount(),
        ],
      ),
    );
  }

  Widget _buildShiftHeader() {
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
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.point_of_sale,
                  color: successColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      currentShift,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Started at 08:00 AM • $employeeName",
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
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Current Register",
                  items: registerOptions,
                  value: selectedRegister,
                  onChanged: (value, label) {
                    selectedRegister = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCashBalance() {
    double variance = cashDrawerCount - currentBalance;

    return Container(
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
              Icon(Icons.account_balance_wallet, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Cash Balance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (variance.abs() <= 10 ? successColor : warningColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  variance >= 0 ? "+\$${variance.toStringAsFixed(2)}" : "-\$${variance.abs().toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: variance.abs() <= 10 ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildBalanceCard("Opening Balance", openingBalance, Icons.start, infoColor),
              _buildBalanceCard("Cash Sales", cashSales, Icons.trending_up, successColor),
              _buildBalanceCard("Tips Received", cashTips, Icons.volunteer_activism, warningColor),
              _buildBalanceCard("Refunds", -cashRefunds, Icons.undo, dangerColor),
              _buildBalanceCard("Expected Balance", currentBalance, Icons.calculate, primaryColor),
              _buildBalanceCard("Drawer Count", cashDrawerCount, Icons.inventory, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(String title, double amount, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            amount < 0 ? "-\$${amount.abs().toStringAsFixed(2)}" : "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: amount < 0 ? dangerColor : primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
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
              Icon(Icons.flash_on, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Transaction Type",
                  items: transactionTypeOptions,
                  value: transactionType,
                  onChanged: (value, label) {
                    transactionType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Amount (\$)",
                  value: transactionAmount,
                  hint: "Enter amount",
                  onChanged: (value) {
                    transactionAmount = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Description",
            value: transactionDescription,
            hint: "Transaction description (optional)",
            onChanged: (value) {
              transactionDescription = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cash In",
                  icon: Icons.add_circle,
                  size: bs.md,
                  onPressed: () {
                    ss("Cash in transaction recorded");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Cash Out",
                  icon: Icons.remove_circle,
                  size: bs.md,
                  onPressed: () {
                    ss("Cash out transaction recorded");
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Open Drawer",
                  icon: Icons.open_in_new,
                  size: bs.md,
                  onPressed: () {
                    ss("Cash drawer opened");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "End Shift",
                  icon: Icons.logout,
                  size: bs.md,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Are you sure you want to end the current shift?");
                    if (isConfirmed) {
                      ss("Shift ended successfully");
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

  Widget _buildCashCount() {
    double totalCash = denominationCounts.fold(0.0, (sum, item) => sum + (item["total"] as double));

    return Container(
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
              Icon(Icons.inventory, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Cash Count",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Total: \$${totalCash.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Column(
            spacing: spXs,
            children: denominationCounts.map((item) => _buildDenominationRow(item)).toList(),
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Count Cash",
                  icon: Icons.calculate,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Print Report",
                  icon: Icons.print,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDenominationRow(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Text(
              "${item["denomination"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Icon(
            item["type"] == "bill" ? Icons.money : Icons.monetization_on,
            size: 16,
            color: disabledBoldColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${item["count"]} pcs",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            "\$${(item["total"] as double).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTransactionFilters(),
          _buildTransactionStats(),
          _buildTransactionsList(),
        ],
      ),
    );
  }

  Widget _buildTransactionFilters() {
    return Container(
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
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Transaction Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Transaction Type",
                  items: [
                    {"label": "All Types", "value": "All"},
                    ...transactionTypeOptions,
                  ],
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Register",
                  items: [
                    {"label": "All Registers", "value": "All"},
                    ...registerOptions,
                  ],
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "From Date",
                  value: DateTime.now(),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTimePicker(
                  label: "From Time",
                  value: TimeOfDay(hour: 8, minute: 0),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionStats() {
    double totalSales = cashTransactions
        .where((t) => t["type"] == "Sale")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
    double totalTips = cashTransactions
        .where((t) => t["type"] == "Tips")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
    double totalRefunds = cashTransactions
        .where((t) => t["type"] == "Refund")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double).abs());

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatsCard("Total Sales", "\$${totalSales.toStringAsFixed(2)}", Icons.trending_up, successColor),
        _buildStatsCard("Total Tips", "\$${totalTips.toStringAsFixed(2)}", Icons.volunteer_activism, warningColor),
        _buildStatsCard("Total Refunds", "\$${totalRefunds.toStringAsFixed(2)}", Icons.undo, dangerColor),
        _buildStatsCard("Transactions", "${cashTransactions.length}", Icons.receipt_long, primaryColor),
      ],
    );
  }

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Container(
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    return Container(
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
              Icon(Icons.history, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ...cashTransactions.map((transaction) => _buildTransactionCard(transaction)),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    Color typeColor = transaction["type"] == "Sale" ? successColor : 
                     transaction["type"] == "Tips" ? warningColor : 
                     transaction["type"] == "Refund" ? dangerColor : 
                     transaction["type"] == "Cash In" ? infoColor : primaryColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getTransactionIcon(transaction["type"]),
                  color: typeColor,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${transaction["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${transaction["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                (transaction["amount"] as double) < 0 
                    ? "-\$${(transaction["amount"] as double).abs().toStringAsFixed(2)}" 
                    : "\$${(transaction["amount"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: (transaction["amount"] as double) < 0 ? dangerColor : primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 12, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${transaction["employee"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.store, size: 12, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${transaction["register"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
              if (transaction["table"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.table_restaurant, size: 12, color: disabledColor),
                SizedBox(width: spXs),
                Text(
                  "${transaction["table"]}",
                  style: TextStyle(fontSize: 11, color: disabledColor),
                ),
              ],
              Spacer(),
              Text(
                "${transaction["time"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case "Sale":
        return Icons.point_of_sale;
      case "Tips":
        return Icons.volunteer_activism;
      case "Refund":
        return Icons.undo;
      case "Cash In":
        return Icons.add_circle;
      case "Cash Out":
        return Icons.remove_circle;
      case "Petty Cash":
        return Icons.account_balance_wallet;
      default:
        return Icons.receipt;
    }
  }

  Widget _buildAllRegistersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRegistersOverview(),
          _buildRegistersList(),
        ],
      ),
    );
  }

  Widget _buildRegistersOverview() {
    int activeRegisters = registerStats.where((r) => r["status"] == "Active").length;
    double totalSales = registerStats.fold(0.0, (sum, r) => sum + (r["totalSales"] as double));
    double totalBalance = registerStats.fold(0.0, (sum, r) => sum + (r["currentBalance"] as double));
    int totalTransactions = registerStats.fold(0, (sum, r) => sum + (r["transactions"] as int));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Active Registers", "$activeRegisters", Icons.store, successColor),
        _buildOverviewCard("Total Sales", "\$${totalSales.toStringAsFixed(2)}", Icons.trending_up, primaryColor),
        _buildOverviewCard("Total Balance", "\$${totalBalance.toStringAsFixed(2)}", Icons.account_balance_wallet, infoColor),
        _buildOverviewCard("Transactions", "$totalTransactions", Icons.receipt_long, warningColor),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistersList() {
    return Container(
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
              Icon(Icons.store, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "All Registers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Register",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ...registerStats.map((register) => _buildRegisterCard(register)),
        ],
      ),
    );
  }

  Widget _buildRegisterCard(Map<String, dynamic> register) {
    Color statusColor = register["status"] == "Active" ? successColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.point_of_sale,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${register["register"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${register["location"]}",
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
                  "${register["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          if (register["status"] == "Active") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Text("Employee:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Spacer(),
                      Text("${register["employee"]}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Current Balance:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Spacer(),
                      Text("\$${(register["currentBalance"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Sales Today:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Spacer(),
                      Text("\$${(register["totalSales"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Transactions:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Spacer(),
                      Text("${register["transactions"]}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(Icons.access_time, size: 12, color: disabledColor),
                SizedBox(width: spXs),
                Text(
                  "Shift started at ${register["shiftStart"]}",
                  style: TextStyle(fontSize: 11, color: disabledColor),
                ),
                Spacer(),
                Text(
                  "Last transaction: ${register["lastTransaction"]}",
                  style: TextStyle(fontSize: 11, color: disabledColor),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildReportFilters(),
          _buildShiftHistory(),
        ],
      ),
    );
  }

  Widget _buildReportFilters() {
    return Container(
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
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Report Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "From Date",
                  value: DateTime.now().subtract(Duration(days: 7)),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "To Date",
                  value: DateTime.now(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Register",
                  items: [
                    {"label": "All Registers", "value": "All"},
                    ...registerOptions,
                  ],
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Shift",
                  items: [
                    {"label": "All Shifts", "value": "All"},
                    {"label": "Day Shift", "value": "Day Shift"},
                    {"label": "Evening Shift", "value": "Evening Shift"},
                    {"label": "Night Shift", "value": "Night Shift"},
                  ],
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate Report",
              icon: Icons.analytics,
              size: bs.md,
              onPressed: () {
                ss("Report generated successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftHistory() {
    return Container(
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
              Icon(Icons.history, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Shift History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ...shiftReports.map((report) => _buildShiftReportCard(report)),
        ],
      ),
    );
  }

  Widget _buildShiftReportCard(Map<String, dynamic> report) {
    double variance = report["variance"] as double;
    Color varianceColor = variance.abs() <= 10 ? successColor : (variance > 0 ? warningColor : dangerColor);

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: primaryColor,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${report["shift"]} - ${report["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${report["employee"]} • ${report["register"]}",
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
                  color: varianceColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  variance >= 0 ? "+\$${variance.toStringAsFixed(2)}" : "-\$${variance.abs().toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: varianceColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text("Opening Balance:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(report["openingBalance"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Text("Closing Balance:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(report["closingBalance"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Text("Total Sales:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(report["totalSales"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    Text("Cash Drawer Count:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(report["cashDrawerCount"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "${report["startTime"]} - ${report["endTime"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
