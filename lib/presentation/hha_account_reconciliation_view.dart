import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaAccountReconciliationView extends StatefulWidget {
  const HhaAccountReconciliationView({super.key});

  @override
  State<HhaAccountReconciliationView> createState() => _HhaAccountReconciliationViewState();
}

class _HhaAccountReconciliationViewState extends State<HhaAccountReconciliationView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPeriod = "daily";
  String selectedAccount = "all";
  String selectedStatus = "all";
  
  // Reconciliation form fields
  String accountType = "cash";
  String statementBalance = "";
  String bookBalance = "";
  String reconciliationDate = "";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  List<Map<String, dynamic>> accountOptions = [
    {"label": "All Accounts", "value": "all"},
    {"label": "Cash", "value": "cash"},
    {"label": "Credit Cards", "value": "credit_cards"},
    {"label": "Bank Deposits", "value": "bank_deposits"},
    {"label": "Accounts Receivable", "value": "accounts_receivable"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Reconciled", "value": "reconciled"},
    {"label": "Pending", "value": "pending"},
    {"label": "Discrepancy", "value": "discrepancy"},
  ];

  List<Map<String, dynamic>> accountTypeOptions = [
    {"label": "Cash Account", "value": "cash"},
    {"label": "Credit Card", "value": "credit_cards"},
    {"label": "Bank Account", "value": "bank_deposits"},
    {"label": "Accounts Receivable", "value": "accounts_receivable"},
  ];

  List<Map<String, dynamic>> reconciliations = [
    {
      "id": "REC001",
      "date": "2024-01-18",
      "account_type": "cash",
      "account_name": "Front Desk Cash",
      "book_balance": 2500.0,
      "statement_balance": 2500.0,
      "difference": 0.0,
      "status": "reconciled",
      "reconciled_by": "John Smith",
      "notes": "Daily cash reconciliation completed successfully",
      "items_count": 15,
      "adjustments": [],
    },
    {
      "id": "REC002",
      "date": "2024-01-18", 
      "account_type": "credit_cards",
      "account_name": "Visa/Mastercard Batch",
      "book_balance": 3450.0,
      "statement_balance": 3425.0,
      "difference": 25.0,
      "status": "discrepancy",
      "reconciled_by": "Sarah Wilson",
      "notes": "Minor discrepancy found - investigating declined transaction",
      "items_count": 8,
      "adjustments": [
        {"description": "Declined transaction adjustment", "amount": 25.0}
      ],
    },
    {
      "id": "REC003",
      "date": "2024-01-17",
      "account_type": "bank_deposits",
      "account_name": "Daily Bank Deposit",
      "book_balance": 5875.0,
      "statement_balance": 5875.0,
      "difference": 0.0,
      "status": "reconciled",
      "reconciled_by": "Emily Davis",
      "notes": "Bank deposit matches system records",
      "items_count": 23,
      "adjustments": [],
    },
    {
      "id": "REC004",
      "date": "2024-01-18",
      "account_type": "accounts_receivable",
      "account_name": "Guest Folios",
      "book_balance": 1250.0,
      "statement_balance": 1250.0,
      "difference": 0.0,
      "status": "reconciled",
      "reconciled_by": "Michael Chen",
      "notes": "Outstanding guest balances verified",
      "items_count": 5,
      "adjustments": [],
    },
    {
      "id": "REC005",
      "date": "2024-01-18",
      "account_type": "cash",
      "account_name": "Restaurant Cash",
      "book_balance": 850.0,
      "statement_balance": 845.0,
      "difference": 5.0,
      "status": "pending",
      "reconciled_by": "Lisa Johnson",
      "notes": "Small variance under investigation",
      "items_count": 12,
      "adjustments": [],
    },
  ];

  List<Map<String, dynamic>> reconciliationItems = [
    {
      "transaction_id": "TXN001",
      "date": "2024-01-18",
      "description": "Room Payment - Cash", 
      "amount": 450.0,
      "type": "credit",
      "status": "matched",
      "reference": "FOL001",
    },
    {
      "transaction_id": "TXN002",
      "date": "2024-01-18",
      "description": "Guest Change",
      "amount": 50.0,
      "type": "debit",
      "status": "matched",
      "reference": "CHANGE001",
    },
    {
      "transaction_id": "TXN003",
      "date": "2024-01-18",
      "description": "Safe Drop",
      "amount": 1000.0,
      "type": "debit",
      "status": "matched",
      "reference": "DROP001",
    },
    {
      "transaction_id": "TXN004",
      "date": "2024-01-18",
      "description": "Restaurant Sale",
      "amount": 75.0,
      "type": "credit",
      "status": "unmatched",
      "reference": "REST001",
    },
  ];

  List<Map<String, dynamic>> get filteredReconciliations {
    return reconciliations.where((rec) {
      bool matchesSearch = searchQuery.isEmpty ||
          (rec["account_name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (rec["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (rec["reconciled_by"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesAccount = selectedAccount == "all" || rec["account_type"] == selectedAccount;
      bool matchesStatus = selectedStatus == "all" || rec["status"] == selectedStatus;
      
      return matchesSearch && matchesAccount && matchesStatus;
    }).toList();
  }

  double get totalReconciled {
    return reconciliations
        .where((r) => r["status"] == "reconciled")
        .fold(0.0, (sum, r) => sum + (r["book_balance"] as double));
  }

  double get totalDiscrepancies {
    return reconciliations
        .where((r) => r["status"] == "discrepancy")
        .fold(0.0, (sum, r) => sum + ((r["difference"] as double).abs()));
  }

  int get pendingCount {
    return reconciliations.where((r) => r["status"] == "pending").length;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Account Reconciliation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Reconciliations", icon: Icon(Icons.account_balance)),
        Tab(text: "New Reconciliation", icon: Icon(Icons.add_circle)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildReconciliationsTab(),
        _buildNewReconciliationTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildReconciliationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search",
                  hint: "Search by account name, ID, or staff",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Account Type",
                  items: accountOptions,
                  value: selectedAccount,
                  onChanged: (value, label) {
                    selectedAccount = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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

          // Summary Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reconciled",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalReconciled.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Discrepancies",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalDiscrepancies.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
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

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$pendingCount",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Accounts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${reconciliations.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Text(
            "Recent Reconciliations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Reconciliations List
          ...filteredReconciliations.map((reconciliation) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: (reconciliation["status"] as String) == "reconciled" 
                      ? successColor 
                      : (reconciliation["status"] as String) == "discrepancy"
                          ? dangerColor
                          : warningColor,
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
                            "${reconciliation["account_name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${reconciliation["id"]} • ${reconciliation["reconciled_by"]}",
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
                          "${reconciliation["date"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: (reconciliation["status"] as String) == "reconciled" 
                                ? successColor.withAlpha(20)
                                : (reconciliation["status"] as String) == "discrepancy"
                                    ? dangerColor.withAlpha(20)
                                    : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${reconciliation["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (reconciliation["status"] as String) == "reconciled" 
                                  ? successColor
                                  : (reconciliation["status"] as String) == "discrepancy"
                                      ? dangerColor
                                      : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Book Balance",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((reconciliation["book_balance"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
                                  "Statement Balance",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((reconciliation["statement_balance"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Difference",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(reconciliation["difference"] as double) >= 0 ? "+" : ""}\$${((reconciliation["difference"] as double).abs()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: (reconciliation["difference"] as double) == 0 
                                        ? successColor 
                                        : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      if ((reconciliation["notes"] as String).isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${reconciliation["notes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Text(
                      "${reconciliation["items_count"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        _viewReconciliationDetails(reconciliation);
                      },
                    ),
                    SizedBox(width: spSm),
                    if ((reconciliation["status"] as String) == "pending")
                      QButton(
                        label: "Complete",
                        size: bs.sm,
                        onPressed: () {
                          _completeReconciliation(reconciliation);
                        },
                      ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildNewReconciliationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Account Selection
          QDropdownField(
            label: "Account Type",
            items: accountTypeOptions,
            value: accountType,
            onChanged: (value, label) {
              accountType = value;
              setState(() {});
            },
          ),

          QDatePicker(
            label: "Reconciliation Date",
            value: reconciliationDate.isNotEmpty 
                ? DateTime.parse(reconciliationDate)
                : DateTime.now(),
            onChanged: (value) {
              reconciliationDate = value.toString().split(' ')[0];
              setState(() {});
            },
          ),

          // Balance Information
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
                  "Balance Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QNumberField(
                  label: "Book Balance",
                  value: bookBalance,
                  hint: "Enter system balance",
                  onChanged: (value) {
                    bookBalance = value;
                    setState(() {});
                  },
                ),

                QNumberField(
                  label: "Statement/Physical Balance",
                  value: statementBalance,
                  hint: "Enter statement or counted balance",
                  onChanged: (value) {
                    statementBalance = value;
                    setState(() {});
                  },
                ),

                if (bookBalance.isNotEmpty && statementBalance.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: ((double.tryParse(statementBalance) ?? 0) - (double.tryParse(bookBalance) ?? 0)) == 0
                          ? successColor.withAlpha(10)
                          : dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: ((double.tryParse(statementBalance) ?? 0) - (double.tryParse(bookBalance) ?? 0)) == 0
                            ? successColor.withAlpha(30)
                            : dangerColor.withAlpha(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          ((double.tryParse(statementBalance) ?? 0) - (double.tryParse(bookBalance) ?? 0)) == 0
                              ? Icons.check_circle
                              : Icons.warning,
                          color: ((double.tryParse(statementBalance) ?? 0) - (double.tryParse(bookBalance) ?? 0)) == 0
                              ? successColor
                              : dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Difference",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${((double.tryParse(statementBalance) ?? 0) - (double.tryParse(bookBalance) ?? 0)) >= 0 ? "+" : ""}\$${(((double.tryParse(statementBalance) ?? 0) - (double.tryParse(bookBalance) ?? 0)).abs()).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ((double.tryParse(statementBalance) ?? 0) - (double.tryParse(bookBalance) ?? 0)) == 0
                                      ? successColor
                                      : dangerColor,
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
          ),

          // Transaction Items Review
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Transaction Items",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Load Items",
                      size: bs.sm,
                      onPressed: () {
                        _loadTransactionItems();
                      },
                    ),
                  ],
                ),

                ...reconciliationItems.map((item) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: (item["status"] as String) == "matched"
                        ? successColor.withAlpha(10)
                        : warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: (item["status"] as String) == "matched"
                          ? successColor.withAlpha(30)
                          : warningColor.withAlpha(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (item["status"] as String) == "matched"
                            ? Icons.check_circle
                            : Icons.help_outline,
                        color: (item["status"] as String) == "matched"
                            ? successColor
                            : warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${item["date"]} • ${item["reference"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${(item["type"] as String) == "debit" ? "-" : "+"}\$${((item["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: (item["type"] as String) == "credit"
                              ? successColor
                              : dangerColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Action Buttons
          Container(
            width: double.infinity,
            child: QButton(
              label: "Complete Reconciliation",
              onPressed: bookBalance.isNotEmpty && 
                         statementBalance.isNotEmpty ? () {
                _completeNewReconciliation();
              } : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Filter Options
          QDropdownField(
            label: "Report Period",
            items: periodOptions,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),

          // Summary Dashboard
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
                  "Reconciliation Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Success Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((reconciliations.where((r) => r["status"] == "reconciled").length / reconciliations.length) * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: fsH4,
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
                            "Total Volume",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((reconciliations.fold(0.0, (sum, r) => sum + (r["book_balance"] as double))) as double).currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avg. Discrepancy",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((totalDiscrepancies / (reconciliations.where((r) => r["status"] == "discrepancy").length > 0 ? reconciliations.where((r) => r["status"] == "discrepancy").length : 1)) as double).currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
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
                            "Items Processed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${reconciliations.fold(0, (sum, r) => sum + (r["items_count"] as int))}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Account Type Breakdown
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
                  "Account Type Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ...["cash", "credit_cards", "bank_deposits", "accounts_receivable"].map((accountType) {
                  final accountRecs = reconciliations.where((r) => r["account_type"] == accountType).toList();
                  final totalAmount = accountRecs.fold(0.0, (sum, r) => sum + (r["book_balance"] as double));
                  final reconciledCount = accountRecs.where((r) => r["status"] == "reconciled").length;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${accountType.replaceAll("_", " ").toUpperCase()}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${reconciledCount}/${accountRecs.length} reconciled",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((totalAmount as double)).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Recent Activity
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
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ...reconciliations.take(5).map((reconciliation) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (reconciliation["status"] as String) == "reconciled" 
                            ? Icons.check_circle
                            : (reconciliation["status"] as String) == "discrepancy"
                                ? Icons.warning
                                : Icons.pending,
                        color: (reconciliation["status"] as String) == "reconciled" 
                            ? successColor
                            : (reconciliation["status"] as String) == "discrepancy"
                                ? dangerColor
                                : warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${reconciliation["account_name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${reconciliation["date"]} • ${reconciliation["reconciled_by"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${((reconciliation["book_balance"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _viewReconciliationDetails(Map<String, dynamic> reconciliation) {
    // Show detailed view
    ss("Viewing details for ${reconciliation["account_name"]}");
  }

  void _completeReconciliation(Map<String, dynamic> reconciliation) async {
    bool isConfirmed = await confirm("Complete reconciliation for ${reconciliation["account_name"]}?");
    if (isConfirmed) {
      reconciliation["status"] = "reconciled";
      setState(() {});
      ss("Reconciliation completed successfully");
    }
  }

  void _loadTransactionItems() {
    // Simulate loading transaction items
    ss("Transaction items loaded");
  }

  void _completeNewReconciliation() async {
    showLoading();
    
    // Simulate completing reconciliation
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    // Clear form
    bookBalance = "";
    statementBalance = "";
    reconciliationDate = "";
    setState(() {});
    
    // Switch to reconciliations tab
    currentTab = 0;
    setState(() {});
    
    ss("Reconciliation completed successfully");
  }
}
