import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsGiftCardsView extends StatefulWidget {
  const EcsGiftCardsView({super.key});

  @override
  State<EcsGiftCardsView> createState() => _EcsGiftCardsViewState();
}

class _EcsGiftCardsViewState extends State<EcsGiftCardsView> {
  int selectedTab = 0;
  
  List<Map<String, dynamic>> myGiftCards = [
    {
      "id": 1,
      "code": "GIFT-2024-001",
      "balance": 50.00,
      "originalAmount": 100.00,
      "expiryDate": "2024-12-31",
      "issueDate": "2024-06-01",
      "from": "Sarah Wilson",
      "message": "Happy Birthday! Enjoy shopping!",
      "status": "active",
    },
    {
      "id": 2,
      "code": "GIFT-2024-002", 
      "balance": 25.00,
      "originalAmount": 25.00,
      "expiryDate": "2024-10-15",
      "issueDate": "2024-05-15",
      "from": "Mom",
      "message": "Get something nice for yourself!",
      "status": "active",
    },
    {
      "id": 3,
      "code": "GIFT-2024-003",
      "balance": 0.00,
      "originalAmount": 75.00,
      "expiryDate": "2024-08-30",
      "issueDate": "2024-04-01",
      "from": "Best Friend",
      "message": "Congratulations on your promotion!",
      "status": "used",
    },
  ];

  List<Map<String, dynamic>> giftCardTemplates = [
    {
      "id": 1,
      "name": "Birthday Celebration",
      "description": "Perfect for birthday gifts",
      "image": "https://picsum.photos/300/200?random=1&keyword=birthday",
      "color": Colors.pink,
      "popular": true,
    },
    {
      "id": 2,
      "name": "Holiday Special",
      "description": "Great for holiday seasons",
      "image": "https://picsum.photos/300/200?random=2&keyword=holiday",
      "color": Colors.red,
      "popular": false,
    },
    {
      "id": 3,
      "name": "Thank You",
      "description": "Express your gratitude",
      "image": "https://picsum.photos/300/200?random=3&keyword=thankyou",
      "color": Colors.blue,
      "popular": true,
    },
    {
      "id": 4,
      "name": "Congratulations",
      "description": "Celebrate achievements",
      "image": "https://picsum.photos/300/200?random=4&keyword=congratulations",
      "color": Colors.green,
      "popular": false,
    },
    {
      "id": 5,
      "name": "Love & Romance",
      "description": "Perfect for special someone",
      "image": "https://picsum.photos/300/200?random=5&keyword=love",
      "color": Colors.purple,
      "popular": true,
    },
    {
      "id": 6,
      "name": "General",
      "description": "For any occasion",
      "image": "https://picsum.photos/300/200?random=6&keyword=gift",
      "color": Colors.orange,
      "popular": false,
    },
  ];

  String redeemCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gift Cards"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo("PurchaseGiftCardView")
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            margin: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: [
                {"label": "My Cards", "value": "my_cards"},
                {"label": "Buy Gift Card", "value": "buy"},
                {"label": "Redeem", "value": "redeem"},
              ],
              value: selectedTab == 0 ? "my_cards" : selectedTab == 1 ? "buy" : "redeem",
              onChanged: (index, label, value, item) {
                selectedTab = index;
                setState(() {});
              },
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: selectedTab == 0
                  ? _buildMyCardsTab()
                  : selectedTab == 1
                      ? _buildBuyTab()
                      : _buildRedeemTab(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyCardsTab() {
    List<Map<String, dynamic>> activeCards = myGiftCards.where((card) => card["status"] == "active").toList();
    List<Map<String, dynamic>> usedCards = myGiftCards.where((card) => card["status"] == "used").toList();

    return Column(
      spacing: spSm,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                Icons.card_giftcard,
                size: 48,
                color: primaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "My Gift Cards",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Manage and use your gift cards",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Total Balance Card
        if (activeCards.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(204)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Text(
                  "Total Available Balance",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "\$${activeCards.fold(0.0, (sum, card) => sum + (card["balance"] as double)).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "From ${activeCards.length} active gift card${activeCards.length > 1 ? 's' : ''}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),

        // Active Cards Section
        if (activeCards.isNotEmpty) ...[
          Row(
            children: [
              Text(
                "Active Cards (${activeCards.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 20,
              ),
            ],
          ),

          ...activeCards.map((card) => _buildGiftCardItem(card)).toList(),
        ],

        // Used Cards Section
        if (usedCards.isNotEmpty) ...[
          Row(
            children: [
              Text(
                "Used Cards (${usedCards.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.history,
                color: disabledColor,
                size: 20,
              ),
            ],
          ),

          ...usedCards.map((card) => _buildGiftCardItem(card)).toList(),
        ],

        // Empty State
        if (myGiftCards.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            child: Column(
              children: [
                Icon(
                  Icons.card_giftcard,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No Gift Cards",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "You don't have any gift cards yet. Buy one or ask someone to send you a gift card.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Buy Gift Card",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    selectedTab = 1;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBuyTab() {
    return Column(
      spacing: spSm,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                Icons.shopping_cart,
                size: 48,
                color: primaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Buy Gift Cards",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Perfect gifts for friends and family",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Quick Purchase Options
        Container(
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
                "Quick Purchase",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Popular amounts:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: [25, 50, 100, 200].map((amount) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - spMd * 4) / 2,
                    child: QButton(
                      label: "\$$amount",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo("PurchaseGiftCardView", amount: amount)
                      },
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Custom Amount",
                  icon: Icons.edit,
                  size: bs.md,
                  onPressed: () {
                    //navigateTo("PurchaseGiftCardView")
                  },
                ),
              ),
            ],
          ),
        ),

        // Templates Section
        Text(
          "Choose a Design",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        // Templates Grid
        ResponsiveGridView(
          minItemWidth: 200,
          children: giftCardTemplates.map((template) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Template Image
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                        child: Image.network(
                          "${template["image"]}",
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (template["popular"] as bool)
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "POPULAR",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Template Details
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: template["color"] as Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Choose",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo("PurchaseGiftCardView", template: template)
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRedeemTab() {
    return Column(
      spacing: spSm,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                Icons.redeem,
                size: 48,
                color: primaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Redeem Gift Card",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Enter your gift card code to add to your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Redeem Form
        Container(
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
                "Gift Card Code",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Enter gift card code",
                value: redeemCode,
                hint: "GIFT-2024-XXXX",
                onChanged: (value) {
                  redeemCode = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Redeem Gift Card",
                  icon: Icons.redeem,
                  size: bs.md,
                  onPressed: redeemCode.isNotEmpty ? () {
                    _redeemGiftCard();
                  } : null,
                ),
              ),
            ],
          ),
        ),

        // Scanner Option
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: 32,
                color: infoColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Scan QR Code",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Use your camera to scan the gift card QR code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spSm),
              QButton(
                label: "Open Scanner",
                icon: Icons.camera_alt,
                size: bs.sm,
                onPressed: () {
                  //navigateTo("QRScannerView")
                },
              ),
            ],
          ),
        ),

        // How it Works
        Container(
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
                "How to Redeem",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...[
                "Enter the gift card code or scan QR code",
                "The balance will be added to your account",
                "Use the balance during checkout",
                "Check remaining balance anytime in My Cards",
              ].asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${entry.key + 1}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGiftCardItem(Map<String, dynamic> card) {
    bool isActive = card["status"] == "active";
    bool hasBalance = (card["balance"] as double) > 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isActive && hasBalance ? primaryColor : disabledOutlineBorderColor,
          width: isActive && hasBalance ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Card Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isActive 
                      ? primaryColor.withAlpha(25) 
                      : disabledColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.card_giftcard,
                  color: isActive ? primaryColor : disabledColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${card["code"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isActive ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    Text(
                      "From: ${card["from"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: isActive 
                      ? successColor.withAlpha(25) 
                      : disabledColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  isActive ? "ACTIVE" : "USED",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isActive ? successColor : disabledColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spSm),

          // Balance and Original Amount
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isActive 
                  ? primaryColor.withAlpha(25) 
                  : disabledColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Balance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(card["balance"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isActive ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Original",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(card["originalAmount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (card["message"] != null && (card["message"] as String).isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Message:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${card["message"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: spSm),

          // Dates and Actions
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expires: ${card["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Issued: ${card["issueDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (isActive && hasBalance)
                QButton(
                  label: "Use Now",
                  size: bs.sm,
                  onPressed: () {
                    ss("Gift card applied to your account");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _redeemGiftCard() async {
    if (redeemCode.trim().isEmpty) {
      se("Please enter a gift card code");
      return;
    }

    // Simulate redemption
    await Future.delayed(Duration(seconds: 1));
    
    // Check if code already exists
    bool codeExists = myGiftCards.any((card) => card["code"] == redeemCode.trim());
    
    if (codeExists) {
      se("This gift card has already been redeemed");
      return;
    }

    // Add new gift card
    Map<String, dynamic> newCard = {
      "id": myGiftCards.length + 1,
      "code": redeemCode.trim(),
      "balance": 50.00, // Simulated balance
      "originalAmount": 50.00,
      "expiryDate": "2024-12-31",
      "issueDate": DateTime.now().toString().split(' ')[0],
      "from": "Gift Card",
      "message": "Successfully redeemed gift card",
      "status": "active",
    };

    myGiftCards.insert(0, newCard);
    redeemCode = "";
    selectedTab = 0; // Switch to My Cards tab
    
    setState(() {});
    ss("Gift card redeemed successfully! \$50.00 added to your account.");
  }
}
