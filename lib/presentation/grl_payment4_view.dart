import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment4View extends StatefulWidget {
  @override
  State<GrlPayment4View> createState() => _GrlPayment4ViewState();
}

class _GrlPayment4ViewState extends State<GrlPayment4View> {
  int currentTab = 0;
  String selectedWallet = "main";
  double mainWalletBalance = 1250.75;
  double rewardsBalance = 450.25;
  double cryptoBalance = 0.0245;
  String transferAmount = "";
  String recipientEmail = "";
  String selectedTopUpMethod = "bank";
  String topUpAmount = "";
  
  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "TXN001",
      "type": "received",
      "amount": 150.00,
      "description": "Payment from John Doe",
      "date": "2024-06-20",
      "status": "completed"
    },
    {
      "id": "TXN002",
      "type": "sent",
      "amount": 75.50,
      "description": "Coffee Shop Payment",
      "date": "2024-06-20",
      "status": "completed"
    },
    {
      "id": "TXN003",
      "type": "topup",
      "amount": 200.00,
      "description": "Bank Transfer Top-up",
      "date": "2024-06-19",
      "status": "completed"
    },
    {
      "id": "TXN004",
      "type": "sent",
      "amount": 25.00,
      "description": "Uber Ride",
      "date": "2024-06-19",
      "status": "pending"
    },
    {
      "id": "TXN005",
      "type": "received",
      "amount": 500.00,
      "description": "Freelance Payment",
      "date": "2024-06-18",
      "status": "completed"
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {"id": "send", "title": "Send Money", "icon": Icons.send, "color": Colors.blue},
    {"id": "receive", "title": "Request Money", "icon": Icons.call_received, "color": Colors.green},
    {"id": "topup", "title": "Top Up", "icon": Icons.add_circle, "color": primaryColor},
    {"id": "withdraw", "title": "Withdraw", "icon": Icons.remove_circle, "color": Colors.orange},
  ];

  List<Map<String, dynamic>> topUpMethods = [
    {"id": "bank", "title": "Bank Transfer", "icon": Icons.account_balance, "fee": "Free"},
    {"id": "card", "title": "Credit/Debit Card", "icon": Icons.credit_card, "fee": "2.5%"},
    {"id": "crypto", "title": "Cryptocurrency", "icon": Icons.currency_bitcoin, "fee": "1%"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildWalletCards(),
          _buildQuickActions(),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spMd, spMd, spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Digital Wallet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Manage your finances",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCards() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          _buildWalletCard(
            "Main Wallet",
            mainWalletBalance,
            "USD",
            Icons.account_balance_wallet,
            primaryColor,
            isSelected: selectedWallet == "main",
            onTap: () {
              selectedWallet = "main";
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: _buildWalletCard(
                  "Rewards",
                  rewardsBalance,
                  "Points",
                  Icons.star,
                  Colors.amber,
                  isSelected: selectedWallet == "rewards",
                  onTap: () {
                    selectedWallet = "rewards";
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildWalletCard(
                  "Crypto",
                  cryptoBalance,
                  "BTC",
                  Icons.currency_bitcoin,
                  Colors.orange,
                  isSelected: selectedWallet == "crypto",
                  onTap: () {
                    selectedWallet = "crypto";
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

  Widget _buildWalletCard(String title, double balance, String currency, IconData icon, Color color, 
      {bool isSelected = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withAlpha(200)],
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
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withAlpha(200),
                fontSize: 12,
              ),
            ),
            Text(
              currency == "BTC" 
                  ? "${balance.toStringAsFixed(4)} $currency"
                  : currency == "Points"
                      ? "${balance.toStringAsFixed(0)} $currency"
                      : "\$${balance.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.white,
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                child: GestureDetector(
                  onTap: () {
                    _handleQuickAction("${action["id"]}");
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
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      margin: EdgeInsets.only(top: spMd),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: currentTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Transactions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentTab == 0 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: currentTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Transfer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentTab == 1 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = 2;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: currentTab == 2 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Top Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentTab == 2 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _getCurrentTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _getCurrentTabContent() {
    switch (currentTab) {
      case 0:
        return _buildTransactionsList();
      case 1:
        return _buildTransferForm();
      case 2:
        return _buildTopUpForm();
      default:
        return Container();
    }
  }

  Widget _buildTransactionsList() {
    return Container(
      margin: EdgeInsets.all(spMd),
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
          SizedBox(height: spMd),
          Expanded(
            child: ListView.builder(
              itemCount: recentTransactions.length,
              itemBuilder: (context, index) {
                final transaction = recentTransactions[index];
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
      case "received":
        icon = Icons.call_received;
        iconColor = successColor;
        amountPrefix = "+";
        break;
      case "sent":
        icon = Icons.send;
        iconColor = dangerColor;
        amountPrefix = "-";
        break;
      case "topup":
        icon = Icons.add_circle;
        iconColor = primaryColor;
        amountPrefix = "+";
        break;
      default:
        icon = Icons.swap_horiz;
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
                  "${transaction["date"]} • ${transaction["id"]}",
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
                "$amountPrefix\$${(transaction["amount"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: transaction["status"] == "completed" 
                      ? successColor.withAlpha(20)
                      : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${transaction["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
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
  }

  Widget _buildTransferForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Send Money",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                QTextField(
                  label: "Recipient Email",
                  value: recipientEmail,
                  hint: "Enter recipient's email address",
                  onChanged: (value) {
                    recipientEmail = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Amount (\$)",
                  value: transferAmount,
                  onChanged: (value) {
                    transferAmount = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Available balance: \$${mainWalletBalance.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
                QButton(
                  label: "Send Money",
                  onPressed: transferAmount.isNotEmpty && recipientEmail.isNotEmpty ? () {
                    _processSendMoney();
                  } : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopUpForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Top Up Wallet",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
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
                  "Select Top-up Method",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ...topUpMethods.map((method) {
                  return GestureDetector(
                    onTap: () {
                      selectedTopUpMethod = "${method["id"]}";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: selectedTopUpMethod == method["id"]
                              ? primaryColor
                              : disabledOutlineBorderColor,
                          width: selectedTopUpMethod == method["id"] ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            method["icon"] as IconData,
                            color: selectedTopUpMethod == method["id"]
                                ? primaryColor
                                : disabledBoldColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${method["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: selectedTopUpMethod == method["id"]
                                    ? primaryColor
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            "${method["fee"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                QNumberField(
                  label: "Top-up Amount (\$)",
                  value: topUpAmount,
                  onChanged: (value) {
                    topUpAmount = value;
                    setState(() {});
                  },
                ),
                QButton(
                  label: "Top Up Wallet",
                  onPressed: topUpAmount.isNotEmpty ? () {
                    _processTopUp();
                  } : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String actionId) {
    switch (actionId) {
      case "send":
        currentTab = 1;
        break;
      case "topup":
        currentTab = 2;
        break;
      case "receive":
        si("Feature coming soon!");
        break;
      case "withdraw":
        si("Feature coming soon!");
        break;
    }
    setState(() {});
  }

  void _processSendMoney() {
    showLoading();
    
    // Simulate money transfer
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Money sent successfully!");
      transferAmount = "";
      recipientEmail = "";
      setState(() {});
    });
  }

  void _processTopUp() {
    showLoading();
    
    // Simulate wallet top-up
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      double amount = double.tryParse(topUpAmount) ?? 0.0;
      mainWalletBalance += amount;
      ss("Wallet topped up successfully!");
      topUpAmount = "";
      setState(() {});
    });
  }
}
