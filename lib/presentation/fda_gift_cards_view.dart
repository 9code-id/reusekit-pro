import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaGiftCardsView extends StatefulWidget {
  const FdaGiftCardsView({super.key});

  @override
  State<FdaGiftCardsView> createState() => _FdaGiftCardsViewState();
}

class _FdaGiftCardsViewState extends State<FdaGiftCardsView> {
  int currentTab = 0;
  
  List<Map<String, dynamic>> myGiftCards = [
    {
      "id": "GC001",
      "amount": 50.0,
      "balance": 32.50,
      "code": "GIFT50ABC",
      "purchaseDate": "2024-03-01T10:00:00",
      "expiryDate": "2025-03-01T23:59:59",
      "status": "active",
      "from": "Self Purchase"
    },
    {
      "id": "GC002",
      "amount": 25.0,
      "balance": 25.0,
      "code": "BIRTHDAY25",
      "purchaseDate": "2024-02-15T14:30:00",
      "expiryDate": "2025-02-15T23:59:59",
      "status": "active",
      "from": "Sarah Johnson"
    },
    {
      "id": "GC003",
      "amount": 100.0,
      "balance": 0.0,
      "code": "HOLIDAY100",
      "purchaseDate": "2023-12-20T16:45:00",
      "expiryDate": "2024-12-20T23:59:59",
      "status": "used",
      "from": "Company Reward"
    }
  ];

  List<Map<String, dynamic>> giftCardOptions = [
    {
      "amount": 25.0,
      "popular": false,
      "description": "Perfect for a quick meal"
    },
    {
      "amount": 50.0,
      "popular": true,
      "description": "Great for family dinners"
    },
    {
      "amount": 100.0,
      "popular": false,
      "description": "Ideal for special occasions"
    },
    {
      "amount": 200.0,
      "popular": false,
      "description": "Premium dining experience"
    }
  ];

  String recipientEmail = "";
  String personalMessage = "";
  double selectedAmount = 50.0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Gift Cards",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "My Cards", icon: Icon(Icons.card_giftcard)),
        Tab(text: "Send Card", icon: Icon(Icons.send)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildMyCardsTab(),
        _buildSendCardTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildMyCardsTab() {
    double totalBalance = myGiftCards.where((card) => card["status"] == "active")
        .fold(0.0, (sum, card) => sum + (card["balance"] as double));
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Total Balance Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 48,
                ),
                Text(
                  "\$${totalBalance.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Total Gift Card Balance",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),

          // Active Gift Cards
          ...myGiftCards.where((card) => card["status"] == "active").map((card) {
            double balance = card["balance"] as double;
            double amount = card["amount"] as double;
            double usedPercent = balance / amount;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withAlpha(200),
                    Colors.purple.withAlpha(150),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gift Card",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "\$${balance.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${card["code"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _copyCardCode(card["code"] as String),
                        child: Icon(
                          Icons.copy,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: usedPercent,
                    backgroundColor: Colors.white.withAlpha(100),
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "From: ${card["from"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Expires: ${DateTime.parse(card["expiryDate"] as String).dMMMy}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          // Quick Actions
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Buy Gift Card",
                  icon: Icons.add_card,
                  size: bs.sm,
                  onPressed: () {
                    setState(() {
                      currentTab = 1;
                    });
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Redeem Code",
                  icon: Icons.redeem,
                  size: bs.sm,
                  onPressed: () => _showRedeemDialog(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSendCardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Gift Card Amount Selection
          Container(
            width: double.infinity,
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
                  "Select Amount",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ResponsiveGridView(
                  minItemWidth: 120,
                  children: giftCardOptions.map((option) {
                    double amount = option["amount"] as double;
                    bool isSelected = selectedAmount == amount;
                    bool isPopular = option["popular"] as bool;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAmount = amount;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(25) : Colors.grey.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            if (isPopular)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Popular",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            Text(
                              "\$${amount.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? primaryColor : Colors.black,
                              ),
                            ),
                            Text(
                              "${option["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Recipient Information
          Container(
            width: double.infinity,
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
                  "Recipient Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QTextField(
                  label: "Recipient Email",
                  value: recipientEmail,
                  hint: "Enter recipient's email address",
                  onChanged: (value) {
                    recipientEmail = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Personal Message",
                  value: personalMessage,
                  hint: "Add a personal message (optional)",
                  onChanged: (value) {
                    personalMessage = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Purchase Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Purchase Gift Card - \$${(selectedAmount + 2.99).toStringAsFixed(2)}",
              size: bs.md,
              onPressed: () => _purchaseGiftCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Transaction History
          ...myGiftCards.map((card) {
            bool isActive = card["status"] == "active";
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green.withAlpha(25) : Colors.grey.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      isActive ? Icons.card_giftcard : Icons.check_circle,
                      color: isActive ? successColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${card["code"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "From: ${card["from"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Purchased: ${DateTime.parse(card["purchaseDate"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: isActive ? successColor : disabledBoldColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          isActive ? "Active" : "Used",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(card["amount"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isActive ? successColor : disabledBoldColor,
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

  void _copyCardCode(String code) {
    ss("Gift card code copied: $code");
  }

  void _showRedeemDialog() {
    String redeemCode = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Redeem Gift Card"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Gift Card Code",
              value: redeemCode,
              hint: "Enter your gift card code",
              onChanged: (value) {
                redeemCode = value;
              },
            ),
          ],
        ),
        actions: [
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () => back(),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Redeem",
                  size: bs.sm,
                  onPressed: () {
                    back();
                    ss("Gift card redeemed successfully!");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _purchaseGiftCard() async {
    if (recipientEmail.isEmpty) {
      se("Please enter recipient email");
      return;
    }
    
    bool isConfirmed = await confirm("Purchase gift card for \$${(selectedAmount + 2.99).toStringAsFixed(2)}?");
    if (isConfirmed) {
      ss("Gift card purchased and sent successfully!");
      // Reset form
      setState(() {
        recipientEmail = "";
        personalMessage = "";
        selectedAmount = 50.0;
      });
    }
  }
}
