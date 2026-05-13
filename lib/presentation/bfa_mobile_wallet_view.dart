import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaMobileWalletView extends StatefulWidget {
  const BfaMobileWalletView({super.key});

  @override
  State<BfaMobileWalletView> createState() => _BfaMobileWalletViewState();
}

class _BfaMobileWalletViewState extends State<BfaMobileWalletView> {
  double walletBalance = 1250000.0;
  String selectedWallet = "main";
  
  List<Map<String, dynamic>> wallets = [
    {
      "id": "main",
      "name": "Main Wallet",
      "balance": 1250000.0,
      "currency": "USD",
      "color": Colors.blue,
      "type": "Primary"
    },
    {
      "id": "savings",
      "name": "Savings Wallet", 
      "balance": 5000000.0,
      "currency": "USD",
      "color": Colors.green,
      "type": "Savings"
    },
    {
      "id": "business",
      "name": "Business Wallet",
      "balance": 750000.0,
      "currency": "USD", 
      "color": Colors.orange,
      "type": "Business"
    },
  ];
  
  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Top Up",
      "icon": Icons.add_circle,
      "color": Colors.green,
      "action": "topup"
    },
    {
      "title": "Transfer",
      "icon": Icons.send,
      "color": Colors.blue,
      "action": "transfer"
    },
    {
      "title": "Pay Bills",
      "icon": Icons.receipt,
      "color": Colors.orange,
      "action": "bills"
    },
    {
      "title": "Request",
      "icon": Icons.request_page,
      "color": Colors.purple,
      "action": "request"
    },
  ];
  
  List<Map<String, dynamic>> recentTransactions = [
    {
      "type": "Top Up",
      "description": "From Bank Account",
      "amount": 500000.0,
      "date": "2024-06-15 14:30",
      "status": "Success",
      "isCredit": true
    },
    {
      "type": "Transfer",
      "description": "To John Doe",
      "amount": 150000.0,
      "date": "2024-06-15 12:15",
      "status": "Success",
      "isCredit": false
    },
    {
      "type": "Payment",
      "description": "Coffee Shop",
      "amount": 25000.0,
      "date": "2024-06-15 10:30",
      "status": "Success",
      "isCredit": false
    },
    {
      "type": "Cashback",
      "description": "Shopping Reward",
      "amount": 15000.0,
      "date": "2024-06-14 18:45",
      "status": "Success",
      "isCredit": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentWallet = wallets.firstWhere((w) => w["id"] == selectedWallet);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Wallet"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet Selection
            Container(
              height: 180,
              child: QHorizontalScroll(
                children: wallets.map((wallet) {
                  final isSelected = selectedWallet == wallet["id"];
                  return GestureDetector(
                    onTap: () {
                      selectedWallet = wallet["id"];
                      setState(() {});
                    },
                    child: Container(
                      width: 280,
                      margin: EdgeInsets.only(
                        right: spSm,
                      ),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            wallet["color"] as Color,
                            (wallet["color"] as Color).withAlpha(200),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: isSelected ? [shadowLg] : [shadowSm],
                        border: isSelected 
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${wallet["name"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${wallet["type"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spLg),
                          Text(
                            "Available Balance",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((wallet["balance"] as double).toDouble()).currency}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white.withAlpha(200),
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${wallet["currency"]} Wallet",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(230),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Row(
              children: quickActions.map((action) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: IconButton(
                            icon: Icon(
                              action["icon"] as IconData,
                              color: action["color"] as Color,
                              size: 28,
                            ),
                            onPressed: () {
                              _handleQuickAction(action["action"]);
                            },
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Wallet Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "This Month",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((850000.0).toDouble()).currency}",
                          style: TextStyle(
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
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_down,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Spent",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((425000.0).toDouble()).currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.savings,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Saved",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((125000.0).toDouble()).currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Recent Transactions
            Row(
              children: [
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Column(
              children: recentTransactions.map((transaction) {
                final isCredit = transaction["isCredit"] as bool;
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isCredit 
                            ? successColor.withAlpha(30)
                            : dangerColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          isCredit ? Icons.add : Icons.remove,
                          color: isCredit ? successColor : dangerColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${transaction["type"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${transaction["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${transaction["date"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${isCredit ? "+" : "-"}\$${((transaction["amount"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isCredit ? successColor : dangerColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${transaction["status"]}",
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
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "topup":
        _showTopUpDialog();
        break;
      case "transfer":
        // Navigate to transfer
        break;
      case "bills":
        // Navigate to bill payment
        break;
      case "request":
        // Navigate to request money
        break;
    }
  }

  void _showTopUpDialog() {
    String amount = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Top Up Wallet"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "Amount (\$)",
              value: amount,
              onChanged: (value) {
                amount = value;
              },
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
              // Handle top up
              Navigator.pop(context);
              ss("Top up successful!");
            },
          ),
        ],
      ),
    );
  }
}
