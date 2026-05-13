import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment6View extends StatefulWidget {
  @override
  State<GrlPayment6View> createState() => _GrlPayment6ViewState();
}

class _GrlPayment6ViewState extends State<GrlPayment6View> {
  List<Map<String, dynamic>> bankAccounts = [
    {
      "id": "acc_001",
      "bankName": "Chase Bank",
      "accountNumber": "****1234",
      "accountType": "Checking",
      "balance": 15420.50,
      "currency": "USD",
      "isDefault": true,
      "color": Colors.blue,
    },
    {
      "id": "acc_002",
      "bankName": "Bank of America",
      "accountNumber": "****5678",
      "accountType": "Savings",
      "balance": 8750.25,
      "currency": "USD",
      "isDefault": false,
      "color": Colors.red,
    },
    {
      "id": "acc_003",
      "bankName": "Wells Fargo",
      "accountNumber": "****9012",
      "accountType": "Business",
      "balance": 42300.00,
      "currency": "USD",
      "isDefault": false,
      "color": Colors.orange,
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "txn_001",
      "type": "debit",
      "amount": 125.50,
      "description": "Amazon Purchase",
      "date": "2024-06-21",
      "category": "Shopping",
      "accountId": "acc_001"
    },
    {
      "id": "txn_002",
      "type": "credit",
      "amount": 2500.00,
      "description": "Salary Deposit",
      "date": "2024-06-20",
      "category": "Income",
      "accountId": "acc_001"
    },
    {
      "id": "txn_003",
      "type": "debit",
      "amount": 85.00,
      "description": "Grocery Store",
      "date": "2024-06-20",
      "category": "Food",
      "accountId": "acc_001"
    },
    {
      "id": "txn_004",
      "type": "transfer",
      "amount": 1000.00,
      "description": "Transfer to Savings",
      "date": "2024-06-19",
      "category": "Transfer",
      "accountId": "acc_001"
    },
    {
      "id": "txn_005",
      "type": "credit",
      "amount": 1000.00,
      "description": "Transfer from Checking",
      "date": "2024-06-19",
      "category": "Transfer",
      "accountId": "acc_002"
    },
  ];

  String selectedAccountId = "acc_001";
  String transferFromAccount = "acc_001";
  String transferToAccount = "acc_002";
  String transferAmount = "";
  String transferNote = "";
  bool showTransferForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Accounts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              si("Add new bank account coming soon!");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAccountCards(),
          _buildQuickActions(),
          Expanded(
            child: showTransferForm ? _buildTransferForm() : _buildTransactionsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCards() {
    return Container(
      height: 200,
      child: QHorizontalScroll(
        children: bankAccounts.map((account) {
          bool isSelected = selectedAccountId == account["id"];
          return GestureDetector(
            onTap: () {
              selectedAccountId = "${account["id"]}";
              setState(() {});
            },
            child: Container(
              width: 300,
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    account["color"] as Color,
                    (account["color"] as Color).withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${account["bankName"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (account["isDefault"] == true)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "DEFAULT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${account["accountType"]} Account",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${account["accountNumber"]}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Available Balance",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "\$${(account["balance"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> actions = [
      {"title": "Transfer", "icon": Icons.swap_horiz, "color": primaryColor, "action": "transfer"},
      {"title": "Pay Bills", "icon": Icons.receipt, "color": Colors.blue, "action": "bills"},
      {"title": "Deposit", "icon": Icons.add_circle, "color": Colors.green, "action": "deposit"},
      {"title": "Statement", "icon": Icons.description, "color": Colors.orange, "action": "statement"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: actions.map((action) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                _handleQuickAction("${action["action"]}");
              },
              child: Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (action["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        action["icon"] as IconData,
                        color: action["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${action["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionsList() {
    Map<String, dynamic> selectedAccount = bankAccounts.firstWhere(
      (account) => account["id"] == selectedAccountId,
    );
    
    List<Map<String, dynamic>> accountTransactions = recentTransactions
        .where((txn) => txn["accountId"] == selectedAccountId)
        .toList();

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${selectedAccount["bankName"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Expanded(
            child: ListView.builder(
              itemCount: accountTransactions.length,
              itemBuilder: (context, index) {
                final transaction = accountTransactions[index];
                return _buildTransactionItem(transaction);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    IconData icon;
    Color iconColor;
    String amountPrefix;
    
    switch (transaction["type"]) {
      case "credit":
        icon = Icons.add_circle;
        iconColor = successColor;
        amountPrefix = "+";
        break;
      case "debit":
        icon = Icons.remove_circle;
        iconColor = dangerColor;
        amountPrefix = "-";
        break;
      case "transfer":
        icon = Icons.swap_horiz;
        iconColor = primaryColor;
        amountPrefix = transaction["accountId"] == selectedAccountId ? "-" : "+";
        break;
      default:
        icon = Icons.help;
        iconColor = disabledBoldColor;
        amountPrefix = "";
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transaction["description"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${transaction["category"]} • ${DateTime.parse(transaction["date"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "$amountPrefix\$${(transaction["amount"] as double).toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: iconColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferForm() {
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
                  "Transfer Money",
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
                  showTransferForm = false;
                  _clearTransferForm();
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
                  "Transfer Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QDropdownField(
                  label: "From Account",
                  items: bankAccounts.map((account) => {
                    "label": "${account["bankName"]} (${account["accountNumber"]})",
                    "value": account["id"],
                  }).toList(),
                  value: transferFromAccount,
                  onChanged: (value, label) {
                    transferFromAccount = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "To Account",
                  items: bankAccounts.where((account) => account["id"] != transferFromAccount)
                      .map((account) => {
                        "label": "${account["bankName"]} (${account["accountNumber"]})",
                        "value": account["id"],
                      }).toList(),
                  value: transferToAccount,
                  onChanged: (value, label) {
                    transferToAccount = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Transfer Amount (\$)",
                  value: transferAmount,
                  onChanged: (value) {
                    transferAmount = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Transfer Note (Optional)",
                  value: transferNote,
                  hint: "Add a note to this transfer",
                  onChanged: (value) {
                    transferNote = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          _buildTransferSummary(),
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
                    "Transfer will be processed immediately. Please verify all details before confirming.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Confirm Transfer",
            onPressed: _canProcessTransfer() ? () {
              _processTransfer();
            } : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTransferSummary() {
    if (transferAmount.isEmpty) return Container();
    
    Map<String, dynamic> fromAccount = bankAccounts.firstWhere(
      (account) => account["id"] == transferFromAccount,
    );
    Map<String, dynamic> toAccount = bankAccounts.firstWhere(
      (account) => account["id"] == transferToAccount,
    );
    
    double amount = double.tryParse(transferAmount) ?? 0.0;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Transfer Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildSummaryRow("From", "${fromAccount["bankName"]} ${fromAccount["accountNumber"]}"),
          _buildSummaryRow("To", "${toAccount["bankName"]} ${toAccount["accountNumber"]}"),
          _buildSummaryRow("Amount", "\$${amount.toStringAsFixed(2)}"),
          _buildSummaryRow("Transfer Fee", "Free"),
          Divider(),
          _buildSummaryRow("Total Amount", "\$${amount.toStringAsFixed(2)}", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? primaryColor : Colors.black,
          ),
        ),
      ],
    );
  }

  bool _canProcessTransfer() {
    return transferFromAccount.isNotEmpty && 
           transferToAccount.isNotEmpty && 
           transferAmount.isNotEmpty &&
           transferFromAccount != transferToAccount;
  }

  void _clearTransferForm() {
    transferAmount = "";
    transferNote = "";
    transferFromAccount = "acc_001";
    transferToAccount = "acc_002";
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "transfer":
        showTransferForm = true;
        setState(() {});
        break;
      case "bills":
        si("Pay Bills feature coming soon!");
        break;
      case "deposit":
        si("Deposit feature coming soon!");
        break;
      case "statement":
        si("Statement download coming soon!");
        break;
    }
  }

  void _processTransfer() {
    showLoading();
    
    // Simulate transfer processing
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      
      double amount = double.tryParse(transferAmount) ?? 0.0;
      
      // Update account balances
      int fromIndex = bankAccounts.indexWhere((acc) => acc["id"] == transferFromAccount);
      int toIndex = bankAccounts.indexWhere((acc) => acc["id"] == transferToAccount);
      
      if (fromIndex != -1 && toIndex != -1) {
        bankAccounts[fromIndex]["balance"] = (bankAccounts[fromIndex]["balance"] as double) - amount;
        bankAccounts[toIndex]["balance"] = (bankAccounts[toIndex]["balance"] as double) + amount;
        
        // Add transaction records
        String txnId1 = "txn_${recentTransactions.length + 1}";
        String txnId2 = "txn_${recentTransactions.length + 2}";
        
        recentTransactions.insert(0, {
          "id": txnId1,
          "type": "transfer",
          "amount": amount,
          "description": "Transfer to ${bankAccounts[toIndex]["bankName"]}",
          "date": DateTime.now().toString(),
          "category": "Transfer",
          "accountId": transferFromAccount,
        });
        
        recentTransactions.insert(0, {
          "id": txnId2,
          "type": "transfer",
          "amount": amount,
          "description": "Transfer from ${bankAccounts[fromIndex]["bankName"]}",
          "date": DateTime.now().toString(),
          "category": "Transfer",
          "accountId": transferToAccount,
        });
      }
      
      showTransferForm = false;
      _clearTransferForm();
      ss("Transfer completed successfully!");
      setState(() {});
    });
  }
}
