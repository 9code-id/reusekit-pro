import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaPaymentCardsView extends StatefulWidget {
  const FdaPaymentCardsView({super.key});

  @override
  State<FdaPaymentCardsView> createState() => _FdaPaymentCardsViewState();
}

class _FdaPaymentCardsViewState extends State<FdaPaymentCardsView> {
  String defaultCardId = "card_001";
  
  List<Map<String, dynamic>> paymentCards = [
    {
      "id": "card_001",
      "type": "Visa",
      "lastFour": "4532",
      "expiryMonth": "12",
      "expiryYear": "2026",
      "holderName": "John Doe",
      "isDefault": true,
      "color": infoColor,
      "icon": Icons.credit_card,
    },
    {
      "id": "card_002",
      "type": "Mastercard",
      "lastFour": "8901",
      "expiryMonth": "08",
      "expiryYear": "2025",
      "holderName": "John Doe",
      "isDefault": false,
      "color": warningColor,
      "icon": Icons.credit_card,
    },
    {
      "id": "card_003",
      "type": "American Express",
      "lastFour": "7845",
      "expiryMonth": "03",
      "expiryYear": "2027",
      "holderName": "John Doe",
      "isDefault": false,
      "color": successColor,
      "icon": Icons.credit_card,
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "txn_001",
      "restaurant": "Pizza Palace",
      "amount": 24.50,
      "date": "Today, 2:30 PM",
      "status": "Completed",
      "cardLastFour": "4532",
      "cardType": "Visa",
    },
    {
      "id": "txn_002",
      "restaurant": "Burger King",
      "amount": 18.75,
      "date": "Yesterday, 7:45 PM",
      "status": "Completed",
      "cardLastFour": "8901",
      "cardType": "Mastercard",
    },
    {
      "id": "txn_003",
      "restaurant": "Sushi Express",
      "amount": 32.90,
      "date": "2 days ago",
      "status": "Completed",
      "cardLastFour": "4532",
      "cardType": "Visa",
    },
    {
      "id": "txn_004",
      "restaurant": "Taco Bell",
      "amount": 15.25,
      "date": "3 days ago",
      "status": "Refunded",
      "cardLastFour": "7845",
      "cardType": "American Express",
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Add New Card",
      "description": "Link a new payment method",
      "icon": Icons.add_card,
      "color": primaryColor,
    },
    {
      "title": "Transaction History",
      "description": "View all your payments",
      "icon": Icons.history,
      "color": infoColor,
    },
    {
      "title": "Security Settings",
      "description": "Manage payment security",
      "icon": Icons.security,
      "color": successColor,
    },
    {
      "title": "Auto-Pay Setup",
      "description": "Set up automatic payments",
      "icon": Icons.autorenew,
      "color": warningColor,
    },
  ];

  void _showCardMenu(Map<String, dynamic> card) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Card Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.edit, color: primaryColor),
              title: Text("Edit Card"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
            if (!(card["isDefault"] as bool))
              ListTile(
                leading: Icon(Icons.star, color: warningColor),
                title: Text("Set as Default"),
                onTap: () {
                  Navigator.pop(context);
                  _setDefaultCard(card["id"]);
                },
              ),
            
            ListTile(
              leading: Icon(Icons.lock, color: infoColor),
              title: Text("Freeze Card"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Remove Card"),
              onTap: () {
                Navigator.pop(context);
                _removeCard(card["id"]);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setDefaultCard(String cardId) {
    for (var card in paymentCards) {
      card["isDefault"] = card["id"] == cardId;
    }
    defaultCardId = cardId;
    setState(() {});
    ss("Default payment method updated");
  }

  void _removeCard(String cardId) async {
    bool isConfirmed = await confirm("Are you sure you want to remove this payment card?");
    if (isConfirmed) {
      paymentCards.removeWhere((card) => card["id"] == cardId);
      setState(() {});
      ss("Payment card removed successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Cards"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Payment Cards
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Your Payment Cards",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${paymentCards.length} cards",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                Column(
                  spacing: spSm,
                  children: paymentCards.map((card) {
                    final isDefault = card["isDefault"] as bool;
                    final cardColor = card["color"] as Color;
                    
                    return GestureDetector(
                      onTap: () => _showCardMenu(card),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              cardColor,
                              cardColor.withAlpha(200),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spMd,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${card["type"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                if (isDefault)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "DEFAULT",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                SizedBox(width: spSm),
                                Icon(
                                  card["icon"] as IconData,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Text(
                                  "•••• •••• •••• ${card["lastFour"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "CARD HOLDER",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white.withAlpha(200),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${card["holderName"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "EXPIRES",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white.withAlpha(200),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${card["expiryMonth"]}/${card["expiryYear"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Quick Actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
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
                  padding: EdgeInsets.all(spSm),
                  minItemWidth: 200,
                  children: quickActions.map((action) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (action["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              action["icon"] as IconData,
                              color: action["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Text(
                            "${action["title"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${action["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Go",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Recent Transactions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
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
                      onTap: () {},
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: recentTransactions.take(4).map((transaction) {
                      final status = transaction["status"] as String;
                      final statusColor = status == "Completed" 
                          ? successColor 
                          : status == "Refunded" 
                              ? warningColor 
                              : dangerColor;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.restaurant,
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
                                    "${transaction["restaurant"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${transaction["cardType"]} •••• ${transaction["cardLastFour"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: statusColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$status",
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: statusColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${transaction["date"]}",
                                    style: TextStyle(
                                      fontSize: 10,
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
                                  status == "Refunded" 
                                      ? "+\$${(transaction["amount"] as double).toStringAsFixed(2)}"
                                      : "-\$${(transaction["amount"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: status == "Refunded" ? successColor : primaryColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: disabledBoldColor,
                                  size: 16,
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
            ),

            // Payment Security
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Payment Security",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your payment information is protected with bank-level security. All transactions are encrypted and processed through secure payment gateways.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.lock, color: successColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "SSL Encrypted",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.verified_user, color: successColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "PCI Compliant",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.shield, color: successColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "Fraud Protection",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
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

            // Spending Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "This Month's Spending",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$245.67",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Spent",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "18",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Orders",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$13.65",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Avg. Order",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
