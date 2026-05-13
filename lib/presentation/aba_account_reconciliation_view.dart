import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAccountReconciliationView extends StatefulWidget {
  const AbaAccountReconciliationView({super.key});

  @override
  State<AbaAccountReconciliationView> createState() => _AbaAccountReconciliationViewState();
}

class _AbaAccountReconciliationViewState extends State<AbaAccountReconciliationView> {
  String selectedAccount = "";
  String reconciliationDate = DateTime.now().toString();
  double bankBalance = 0.0;
  double bookBalance = 0.0;
  double difference = 0.0;
  bool isReconciled = false;
  String statementNumber = "";
  String notes = "";
  
  List<Map<String, dynamic>> accounts = [
    {"label": "Chase Business Checking - *1234", "value": "chase_1234"},
    {"label": "Wells Fargo Savings - *5678", "value": "wells_5678"},
    {"label": "Bank of America Credit - *9012", "value": "boa_9012"},
    {"label": "Citibank Money Market - *3456", "value": "citi_3456"},
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "1",
      "date": "2024-12-15",
      "description": "ACH Transfer - Vendor Payment",
      "amount": -2500.00,
      "type": "transfer",
      "cleared": false,
      "reconciled": false,
    },
    {
      "id": "2", 
      "date": "2024-12-14",
      "description": "Wire Transfer - Client Payment",
      "amount": 7500.00,
      "type": "deposit",
      "cleared": true,
      "reconciled": false,
    },
    {
      "id": "3",
      "date": "2024-12-13", 
      "description": "Check #1001 - Office Rent",
      "amount": -3200.00,
      "type": "check",
      "cleared": false,
      "reconciled": false,
    },
    {
      "id": "4",
      "date": "2024-12-12",
      "description": "Direct Deposit - Customer Payment",
      "amount": 1850.00,
      "type": "deposit",
      "cleared": true,
      "reconciled": false,
    },
    {
      "id": "5",
      "date": "2024-12-11",
      "description": "Bank Fee - Monthly Service",
      "amount": -25.00,
      "type": "fee",
      "cleared": true,
      "reconciled": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    bankBalance = 15420.50;
    bookBalance = 14895.50;
    _calculateDifference();
  }

  void _calculateDifference() {
    difference = bankBalance - bookBalance;
    setState(() {});
  }

  void _toggleTransactionReconciled(String transactionId) {
    final index = transactions.indexWhere((t) => t["id"] == transactionId);
    if (index != -1) {
      transactions[index]["reconciled"] = !transactions[index]["reconciled"];
      setState(() {});
    }
  }

  void _completeReconciliation() async {
    if (selectedAccount.isEmpty) {
      se("Please select an account to reconcile");
      return;
    }
    
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    if (difference.abs() < 0.01) {
      ss("Account reconciliation completed successfully!");
      isReconciled = true;
      setState(() {});
    } else {
      sw("There is still a difference of \$${difference.abs().currency}. Please review transactions.");
    }
  }

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case 'deposit':
        return successColor;
      case 'check':
        return warningColor;
      case 'transfer':
        return infoColor;
      case 'fee':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTransactionTypeIcon(String type) {
    switch (type) {
      case 'deposit':
        return Icons.add_circle;
      case 'check':
        return Icons.receipt;
      case 'transfer':
        return Icons.swap_horiz;
      case 'fee':
        return Icons.remove_circle;
      default:
        return Icons.account_balance_wallet;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reconciledCount = transactions.where((t) => t["reconciled"] == true).length;
    final unreconciledTransactions = transactions.where((t) => t["reconciled"] == false).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Reconciliation"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to reconciliation history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isReconciled 
                    ? successColor.withAlpha(20) 
                    : primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isReconciled 
                      ? successColor.withAlpha(100)
                      : primaryColor.withAlpha(30),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isReconciled ? Icons.check_circle : Icons.balance,
                    color: isReconciled ? successColor : primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isReconciled 
                              ? "Account Reconciled" 
                              : "Bank Reconciliation",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: isReconciled ? successColor : primaryColor,
                          ),
                        ),
                        Text(
                          isReconciled
                              ? "All transactions have been matched and balanced"
                              : "Match bank statement with your records",
                          style: TextStyle(
                            color: isReconciled ? successColor : primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Reconciliation Setup
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reconciliation Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Select Account",
                    items: accounts,
                    value: selectedAccount,
                    validator: Validator.required,
                    onChanged: (value, label) {
                      selectedAccount = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Statement Date",
                          value: DateTime.parse(reconciliationDate),
                          onChanged: (value) {
                            reconciliationDate = value.toString();
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Statement Number",
                          value: statementNumber,
                          hint: "Enter statement #",
                          onChanged: (value) {
                            statementNumber = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Balance Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance Comparison",
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
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Bank Statement",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${bankBalance.currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
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
                            border: Border.all(color: successColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Book Balance",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${bookBalance.currency}",
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
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Bank Balance",
                          value: bankBalance.toString(),
                          onChanged: (value) {
                            bankBalance = double.tryParse(value) ?? 0.0;
                            _calculateDifference();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Book Balance",
                          value: bookBalance.toString(),
                          onChanged: (value) {
                            bookBalance = double.tryParse(value) ?? 0.0;
                            _calculateDifference();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (difference.abs() < 0.01 ? successColor : dangerColor).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: (difference.abs() < 0.01 ? successColor : dangerColor).withAlpha(100),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Difference",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: difference.abs() < 0.01 ? successColor : dangerColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${difference >= 0 ? '+' : '-'}\$${difference.abs().currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: difference.abs() < 0.01 ? successColor : dangerColor,
                          ),
                        ),
                        if (difference.abs() < 0.01)
                          Text(
                            "✓ Balanced",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Progress Summary
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
                      children: [
                        Text(
                          "$reconciledCount",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Reconciled",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${unreconciledTransactions.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${transactions.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Transactions List
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transactions to Reconcile",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${unreconciledTransactions.length} pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...transactions.map((transaction) {
                    final isReconciled = transaction["reconciled"] as bool;
                    final amount = transaction["amount"] as double;
                    final type = transaction["type"] as String;
                    final typeColor = _getTransactionTypeColor(type);
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isReconciled 
                            ? successColor.withAlpha(10) 
                            : Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isReconciled 
                              ? successColor.withAlpha(50)
                              : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _toggleTransactionReconciled(transaction["id"]),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isReconciled ? successColor : Colors.transparent,
                                border: Border.all(
                                  color: isReconciled ? successColor : disabledOutlineBorderColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: isReconciled
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            _getTransactionTypeIcon(type),
                            color: typeColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${transaction["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${DateTime.parse(transaction["date"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: typeColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        type.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: typeColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${amount >= 0 ? '+' : ''}\$${amount.abs().currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: amount >= 0 ? successColor : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Notes Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reconciliation Notes",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QMemoField(
                    label: "Notes",
                    value: notes,
                    hint: "Add any notes about this reconciliation...",
                    onChanged: (value) {
                      notes = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              width: double.infinity,
              child: Column(
                spacing: spSm,
                children: [
                  QButton(
                    label: difference.abs() < 0.01 
                        ? "Complete Reconciliation" 
                        : "Save Progress",
                    size: bs.md,
                    onPressed: _completeReconciliation,
                  ),
                  QButton(
                    label: "Cancel",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
