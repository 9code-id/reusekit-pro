import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaVirtualCurrencyView extends StatefulWidget {
  const GeaVirtualCurrencyView({super.key});

  @override
  State<GeaVirtualCurrencyView> createState() => _GeaVirtualCurrencyViewState();
}

class _GeaVirtualCurrencyViewState extends State<GeaVirtualCurrencyView> {
  String selectedTab = "Balance";

  Map<String, dynamic> currencyBalance = {
    "coins": 12500,
    "gems": 485,
    "tokens": 127,
    "energy": 85,
  };

  List<Map<String, dynamic>> currencyPackages = [
    {
      "id": 1,
      "name": "Small Coin Pack",
      "currency": "coins",
      "amount": 1000,
      "price": 2.99,
      "bonus": 0,
      "image": "https://picsum.photos/150/150?random=1&keyword=coins",
    },
    {
      "id": 2,
      "name": "Medium Coin Pack",
      "currency": "coins",
      "amount": 2500,
      "price": 6.99,
      "bonus": 250,
      "image": "https://picsum.photos/150/150?random=2&keyword=coins",
    },
    {
      "id": 3,
      "name": "Large Coin Pack",
      "currency": "coins",
      "amount": 5000,
      "price": 12.99,
      "bonus": 1000,
      "image": "https://picsum.photos/150/150?random=3&keyword=coins",
    },
    {
      "id": 4,
      "name": "Gem Bundle",
      "currency": "gems",
      "amount": 100,
      "price": 9.99,
      "bonus": 20,
      "image": "https://picsum.photos/150/150?random=4&keyword=gems",
    },
    {
      "id": 5,
      "name": "Premium Gem Pack",
      "currency": "gems",
      "amount": 500,
      "price": 39.99,
      "bonus": 150,
      "image": "https://picsum.photos/150/150?random=5&keyword=gems",
    },
    {
      "id": 6,
      "name": "Token Pack",
      "currency": "tokens",
      "amount": 50,
      "price": 4.99,
      "bonus": 5,
      "image": "https://picsum.photos/150/150?random=6&keyword=token",
    },
  ];

  List<Map<String, dynamic>> transactionHistory = [
    {
      "id": 1,
      "type": "Purchase",
      "currency": "coins",
      "amount": 2500,
      "description": "Medium Coin Pack",
      "date": "2024-06-15",
      "time": "14:30",
    },
    {
      "id": 2,
      "type": "Spent",
      "currency": "coins",
      "amount": -1000,
      "description": "Weapon upgrade",
      "date": "2024-06-14",
      "time": "16:45",
    },
    {
      "id": 3,
      "type": "Earned",
      "currency": "gems",
      "amount": 50,
      "description": "Daily reward",
      "date": "2024-06-14",
      "time": "10:00",
    },
    {
      "id": 4,
      "type": "Purchase",
      "currency": "gems",
      "amount": 120,
      "description": "Gem Bundle",
      "date": "2024-06-13",
      "time": "12:15",
    },
    {
      "id": 5,
      "type": "Spent",
      "currency": "gems",
      "amount": -75,
      "description": "Premium chest",
      "date": "2024-06-12",
      "time": "18:20",
    },
  ];

  Color _getCurrencyColor(String currency) {
    switch (currency) {
      case "coins":
        return warningColor;
      case "gems":
        return primaryColor;
      case "tokens":
        return successColor;
      case "energy":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCurrencyIcon(String currency) {
    switch (currency) {
      case "coins":
        return Icons.monetization_on;
      case "gems":
        return Icons.diamond;
      case "tokens":
        return Icons.token;
      case "energy":
        return Icons.battery_charging_full;
      default:
        return Icons.help;
    }
  }

  Color _getTransactionColor(String type) {
    switch (type) {
      case "Purchase":
      case "Earned":
        return successColor;
      case "Spent":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtual Currency"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh currency balance
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Balance";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "Balance" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Balance",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "Balance" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Purchase";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "Purchase" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Purchase",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "Purchase" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "History";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "History" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "History" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: selectedTab == "Balance" 
                ? _buildBalanceView()
                : selectedTab == "Purchase"
                    ? _buildPurchaseView()
                    : _buildHistoryView(),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Balance Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: currencyBalance.entries.map((entry) {
              final currency = entry.key;
              final amount = entry.value;
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      _getCurrencyIcon(currency),
                      color: _getCurrencyColor(currency),
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      currency.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${amount}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: _getCurrencyColor(currency),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
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
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Buy Coins",
                        size: bs.sm,
                        onPressed: () {
                          selectedTab = "Purchase";
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Buy Gems",
                        size: bs.sm,
                        onPressed: () {
                          selectedTab = "Purchase";
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Transactions
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        selectedTab = "History";
                        setState(() {});
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...transactionHistory.take(3).map((transaction) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getCurrencyIcon(transaction["currency"]),
                          color: _getCurrencyColor(transaction["currency"]),
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${transaction["date"]} ${transaction["time"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${(transaction["amount"] as int) > 0 ? '+' : ''}${transaction["amount"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getTransactionColor(transaction["type"]),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Purchase Banner
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.diamond,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get More Currency",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Choose from our variety of currency packages",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Currency Packages
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: currencyPackages.map((package) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Currency Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${package["image"]}",
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spSm),

                    Text(
                      "${package["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spXs),

                    // Amount and Bonus
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getCurrencyIcon(package["currency"]),
                          color: _getCurrencyColor(package["currency"]),
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${package["amount"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getCurrencyColor(package["currency"]),
                          ),
                        ),
                        if ((package["bonus"] as int) > 0) ...[
                          Text(
                            " + ${package["bonus"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ],
                    ),

                    if ((package["bonus"] as int) > 0) ...[
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "BONUS +${package["bonus"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: spSm),

                    // Price
                    Text(
                      "\$${(package["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Purchase Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Purchase",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('CurrencyPurchaseView', arguments: package)
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // History Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Transactions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${transactionHistory.length}",
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
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "This Month",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${transactionHistory.where((t) => t["date"].toString().startsWith("2024-06")).length}",
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
            ],
          ),

          // Transaction List
          ...transactionHistory.map((transaction) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: _getTransactionColor(transaction["type"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      _getCurrencyIcon(transaction["currency"]),
                      color: _getCurrencyColor(transaction["currency"]),
                      size: 24,
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
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                                color: _getTransactionColor(transaction["type"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${transaction["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getTransactionColor(transaction["type"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${transaction["date"]} ${transaction["time"]}",
                              style: TextStyle(
                                fontSize: 10,
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
                        "${(transaction["amount"] as int) > 0 ? '+' : ''}${transaction["amount"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _getTransactionColor(transaction["type"]),
                        ),
                      ),
                      Text(
                        transaction["currency"].toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getCurrencyColor(transaction["currency"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
