import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaWalletView extends StatefulWidget {
  const SpaWalletView({super.key});

  @override
  State<SpaWalletView> createState() => _SpaWalletViewState();
}

class _SpaWalletViewState extends State<SpaWalletView> {
  double walletBalance = 1250.75;
  String selectedPeriod = "this_month";
  int selectedTabIndex = 0;
  String selectedAction = "";

  List<Map<String, dynamic>> transactionHistory = [
    {
      "id": "TXN001",
      "type": "credit",
      "amount": 100.00,
      "description": "Cashback from purchase",
      "date": "2024-01-15",
      "time": "14:30",
      "status": "completed",
      "icon": Icons.add_circle,
      "color": successColor,
    },
    {
      "id": "TXN002", 
      "type": "debit",
      "amount": 25.50,
      "description": "Payment for Order #12345",
      "date": "2024-01-14",
      "time": "10:15",
      "status": "completed",
      "icon": Icons.remove_circle,
      "color": dangerColor,
    },
    {
      "id": "TXN003",
      "type": "credit",
      "amount": 50.00,
      "description": "Refund for returned item",
      "date": "2024-01-13",
      "time": "16:45",
      "status": "completed", 
      "icon": Icons.add_circle,
      "color": successColor,
    },
    {
      "id": "TXN004",
      "type": "debit",
      "amount": 75.25,
      "description": "Withdrawal to bank account",
      "date": "2024-01-12",
      "time": "09:20",
      "status": "pending",
      "icon": Icons.remove_circle,
      "color": warningColor,
    },
    {
      "id": "TXN005",
      "type": "credit",
      "amount": 200.00,
      "description": "Wallet top-up",
      "date": "2024-01-10",
      "time": "12:00",
      "status": "completed",
      "icon": Icons.add_circle,
      "color": successColor,
    },
    {
      "id": "TXN006",
      "type": "debit",
      "amount": 35.75,
      "description": "Payment for Order #12340",
      "date": "2024-01-09",
      "time": "18:30",
      "status": "completed",
      "icon": Icons.remove_circle,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "id": "top_up",
      "title": "Top Up",
      "subtitle": "Add money to wallet",
      "icon": Icons.add,
      "color": primaryColor,
    },
    {
      "id": "withdraw",
      "title": "Withdraw",
      "subtitle": "Transfer to bank",
      "icon": Icons.arrow_upward,
      "color": successColor,
    },
    {
      "id": "send",
      "title": "Send Money",
      "subtitle": "Transfer to friend",
      "icon": Icons.send,
      "color": infoColor,
    },
    {
      "id": "request",
      "title": "Request",
      "subtitle": "Request payment",
      "icon": Icons.request_quote,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "1",
      "type": "bank",
      "name": "Bank of America",
      "number": "**** 1234",
      "icon": Icons.account_balance,
      "is_primary": true,
    },
    {
      "id": "2", 
      "type": "card",
      "name": "Visa Credit Card",
      "number": "**** 5678",
      "icon": Icons.credit_card,
      "is_primary": false,
    },
    {
      "id": "3",
      "type": "paypal",
      "name": "PayPal Account",
      "number": "john@example.com",
      "icon": Icons.payment,
      "is_primary": false,
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "This Year", "value": "this_year"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wallet"),
        actions: [
          GestureDetector(
            onTap: () => _showTransactionHistory(),
            child: Icon(
              Icons.history,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _showSettings(),
            child: Icon(
              Icons.settings,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWalletBalanceCard(),
            _buildQuickActions(),
            _buildRecentTransactions(),
            _buildPaymentMethods(),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletBalanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallet Balance",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(200),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
          Text(
            "\$${walletBalance.currency}",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add Money",
                  size: bs.sm,
                  onPressed: () => _showTopUpDialog(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: Colors.white.withAlpha(100)),
                  ),
                  child: GestureDetector(
                    onTap: () => _showWithdrawDialog(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Withdraw",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: quickActions.map((action) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: GestureDetector(
                onTap: () => _handleQuickAction(action["id"]),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (action["color"] as Color).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        action["icon"] as IconData,
                        color: action["color"] as Color,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${action["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${action["subtitle"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    List<Map<String, dynamic>> recentTransactions = transactionHistory.take(3).toList();
    
    return Column(
      spacing: spSm,
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
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () => _showTransactionHistory(),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: recentTransactions.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> transaction = entry.value;
              bool isLast = index == recentTransactions.length - 1;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: !isLast ? Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ) : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (transaction["color"] as Color).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        transaction["icon"] as IconData,
                        color: transaction["color"] as Color,
                        size: 20,
                      ),
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${transaction["date"]} • ${transaction["time"]}",
                            style: TextStyle(
                              fontSize: 12,
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
                          "${transaction["type"] == 'credit' ? '+' : '-'}\$${(transaction["amount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: transaction["color"] as Color,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: transaction["status"] == "completed" 
                                ? successColor.withAlpha(25)
                                : warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${transaction["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: transaction["status"] == "completed" 
                                  ? successColor
                                  : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment Methods",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () => _showAddPaymentMethodDialog(),
              child: Text(
                "Add New",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: paymentMethods.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> method = entry.value;
              bool isLast = index == paymentMethods.length - 1;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: !isLast ? Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ) : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        method["icon"] as IconData,
                        color: primaryColor,
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
                              Text(
                                "${method["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              if (method["is_primary"]) ...[
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "PRIMARY",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            "${method["number"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showPaymentMethodOptions(method),
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showTopUpDialog() {
    String amount = "";
    String selectedPaymentMethod = paymentMethods.first["id"];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Top Up Wallet"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QNumberField(
              label: "Amount (\$)",
              value: amount,
              onChanged: (value) => amount = value,
            ),
            QDropdownField(
              label: "Payment Method",
              items: paymentMethods.map((method) => {
                "label": "${method["name"]} ${method["number"]}",
                "value": method["id"],
              }).toList(),
              value: selectedPaymentMethod,
              onChanged: (value, label) => selectedPaymentMethod = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Top Up",
            size: bs.sm,
            onPressed: () {
              if (amount.isNotEmpty) {
                double topUpAmount = double.parse(amount);
                setState(() {
                  walletBalance += topUpAmount;
                  transactionHistory.insert(0, {
                    "id": "TXN${DateTime.now().millisecondsSinceEpoch}",
                    "type": "credit",
                    "amount": topUpAmount,
                    "description": "Wallet top-up",
                    "date": DateTime.now().dMMMy,
                    "time": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
                    "status": "completed",
                    "icon": Icons.add_circle,
                    "color": successColor,
                  });
                });
                Navigator.pop(context);
                ss("Wallet topped up successfully!");
              }
            },
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog() {
    String amount = "";
    String selectedAccount = paymentMethods.first["id"];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Withdraw Money"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QNumberField(
              label: "Amount (\$)",
              value: amount,
              onChanged: (value) => amount = value,
            ),
            QDropdownField(
              label: "Withdraw To",
              items: paymentMethods.where((method) => method["type"] != "card").map((method) => {
                "label": "${method["name"]} ${method["number"]}",
                "value": method["id"],
              }).toList(),
              value: selectedAccount,
              onChanged: (value, label) => selectedAccount = value,
            ),
            Text(
              "Available Balance: \$${walletBalance.currency}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Withdraw",
            size: bs.sm,
            onPressed: () {
              if (amount.isNotEmpty) {
                double withdrawAmount = double.parse(amount);
                if (withdrawAmount <= walletBalance) {
                  setState(() {
                    walletBalance -= withdrawAmount;
                    transactionHistory.insert(0, {
                      "id": "TXN${DateTime.now().millisecondsSinceEpoch}",
                      "type": "debit",
                      "amount": withdrawAmount,
                      "description": "Withdrawal to bank account",
                      "date": DateTime.now().dMMMy,
                      "time": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
                      "status": "pending",
                      "icon": Icons.remove_circle,
                      "color": warningColor,
                    });
                  });
                  Navigator.pop(context);
                  ss("Withdrawal request submitted!");
                } else {
                  se("Insufficient balance!");
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String actionId) {
    switch (actionId) {
      case "top_up":
        _showTopUpDialog();
        break;
      case "withdraw":
        _showWithdrawDialog();
        break;
      case "send":
        _showSendMoneyDialog();
        break;
      case "request":
        _showRequestMoneyDialog();
        break;
    }
  }

  void _showSendMoneyDialog() {
    String recipient = "";
    String amount = "";
    String note = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Send Money"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Recipient Email/Phone",
              value: recipient,
              onChanged: (value) => recipient = value,
            ),
            QNumberField(
              label: "Amount (\$)",
              value: amount,
              onChanged: (value) => amount = value,
            ),
            QTextField(
              label: "Note (Optional)",
              value: note,
              onChanged: (value) => note = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Send",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Money sent successfully!");
            },
          ),
        ],
      ),
    );
  }

  void _showRequestMoneyDialog() {
    String requester = "";
    String amount = "";
    String reason = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Request Money"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "From Email/Phone",
              value: requester,
              onChanged: (value) => requester = value,
            ),
            QNumberField(
              label: "Amount (\$)",
              value: amount,
              onChanged: (value) => amount = value,
            ),
            QTextField(
              label: "Reason",
              value: reason,
              onChanged: (value) => reason = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Send Request",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Payment request sent!");
            },
          ),
        ],
      ),
    );
  }

  void _showTransactionHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction History"),
            QDropdownField(
              label: "Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: transactionHistory.length,
            itemBuilder: (context, index) {
              var transaction = transactionHistory[index];
              return Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  border: index < transactionHistory.length - 1 ? Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ) : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: (transaction["color"] as Color).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        transaction["icon"] as IconData,
                        color: transaction["color"] as Color,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${transaction["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${transaction["date"]} • ${transaction["time"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${transaction["type"] == 'credit' ? '+' : '-'}\$${(transaction["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: transaction["color"] as Color,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showAddPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Payment Method"),
        content: Text("This feature will allow you to add new payment methods like bank accounts, credit cards, or digital wallets."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Payment method feature coming soon!");
            },
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodOptions(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Method Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!method["is_primary"])
              ListTile(
                leading: Icon(Icons.star),
                title: Text("Set as Primary"),
                onTap: () {
                  setState(() {
                    for (var pm in paymentMethods) {
                      pm["is_primary"] = pm["id"] == method["id"];
                    }
                  });
                  Navigator.pop(context);
                  ss("Payment method set as primary!");
                },
              ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit"),
              onTap: () {
                Navigator.pop(context);
                si("Edit payment method feature coming soon!");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Remove", style: TextStyle(color: dangerColor)),
              onTap: () {
                Navigator.pop(context);
                _confirmRemovePaymentMethod(method);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRemovePaymentMethod(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Remove Payment Method"),
        content: Text("Are you sure you want to remove ${method["name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Remove",
            size: bs.sm,
            onPressed: () {
              setState(() {
                paymentMethods.removeWhere((pm) => pm["id"] == method["id"]);
              });
              Navigator.pop(context);
              ss("Payment method removed!");
            },
          ),
        ],
      ),
    );
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Wallet Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.security),
              title: Text("Security Settings"),
              onTap: () {
                Navigator.pop(context);
                si("Security settings feature coming soon!");
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
              onTap: () {
                Navigator.pop(context);
                si("Notification settings feature coming soon!");
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help & Support"),
              onTap: () {
                Navigator.pop(context);
                si("Help & support feature coming soon!");
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
