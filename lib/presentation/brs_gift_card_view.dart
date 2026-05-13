import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsGiftCardView extends StatefulWidget {
  const BrsGiftCardView({super.key});

  @override
  State<BrsGiftCardView> createState() => _BrsGiftCardViewState();
}

class _BrsGiftCardViewState extends State<BrsGiftCardView> {
  String selectedTab = "Buy";
  String selectedAmount = "";
  String recipientName = "";
  String recipientEmail = "";
  String senderName = "";
  String personalMessage = "";
  String giftCardCode = "";
  DateTime deliveryDate = DateTime.now();
  
  List<Map<String, dynamic>> predefinedAmounts = [
    {"amount": 25.0, "bonus": 0.0},
    {"amount": 50.0, "bonus": 5.0},
    {"amount": 100.0, "bonus": 15.0},
    {"amount": 200.0, "bonus": 30.0},
  ];

  List<Map<String, dynamic>> giftCardDesigns = [
    {
      "id": 1,
      "name": "Classic",
      "image": "https://picsum.photos/300/200?random=1&keyword=elegant",
      "color": primaryColor,
    },
    {
      "id": 2,
      "name": "Vintage",
      "image": "https://picsum.photos/300/200?random=2&keyword=vintage",
      "color": Colors.brown,
    },
    {
      "id": 3,
      "name": "Modern",
      "image": "https://picsum.photos/300/200?random=3&keyword=modern",
      "color": Colors.teal,
    },
    {
      "id": 4,
      "name": "Birthday",
      "image": "https://picsum.photos/300/200?random=4&keyword=birthday",
      "color": Colors.pink,
    },
  ];

  int selectedDesign = 1;

  List<Map<String, dynamic>> myGiftCards = [
    {
      "code": "GC2024001",
      "amount": 75.0,
      "balance": 75.0,
      "purchaseDate": "2024-03-15",
      "expiryDate": "2025-03-15",
      "status": "Active",
      "design": "Classic",
    },
    {
      "code": "GC2024002",
      "amount": 50.0,
      "balance": 25.0,
      "purchaseDate": "2024-02-28",
      "expiryDate": "2025-02-28",
      "status": "Active",
      "design": "Vintage",
    },
    {
      "code": "GC2024003",
      "amount": 100.0,
      "balance": 0.0,
      "purchaseDate": "2024-01-20",
      "expiryDate": "2025-01-20",
      "status": "Used",
      "design": "Modern",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gift Cards"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // View purchase history
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Buy";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "Buy" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Text(
                        "Buy Gift Card",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == "Buy" ? Colors.white : disabledBoldColor,
                          fontWeight: selectedTab == "Buy" ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Redeem";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "Redeem" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Text(
                        "Redeem Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == "Redeem" ? Colors.white : disabledBoldColor,
                          fontWeight: selectedTab == "Redeem" ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "My Cards";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "My Cards" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Text(
                        "My Cards",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == "My Cards" ? Colors.white : disabledBoldColor,
                          fontWeight: selectedTab == "My Cards" ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "Buy":
        return _buildBuyGiftCard();
      case "Redeem":
        return _buildRedeemCode();
      case "My Cards":
        return _buildMyCards();
      default:
        return Container();
    }
  }

  Widget _buildBuyGiftCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withAlpha(200)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.card_giftcard, size: 40, color: Colors.white),
              SizedBox(height: spSm),
              Text(
                "Give the Gift of\nGrooming",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Perfect for any occasion",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(230),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spLg),

        // Select Amount
        Text(
          "Select Amount",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: predefinedAmounts.map((amount) {
            final isSelected = selectedAmount == amount["amount"].toString();
            return GestureDetector(
              onTap: () {
                selectedAmount = amount["amount"].toString();
                setState(() {});
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - spMd * 3) / 2,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                  boxShadow: isSelected ? [shadowSm] : [],
                ),
                child: Column(
                  children: [
                    Text(
                      "\$${(amount["amount"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    if ((amount["bonus"] as double) > 0) ...[
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white.withAlpha(50) : successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "+\$${(amount["bonus"] as double).toStringAsFixed(0)} Bonus",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : successColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: spLg),

        // Custom Amount
        Text(
          "Or Enter Custom Amount",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        QNumberField(
          label: "Custom Amount (\$)",
          value: selectedAmount.isNotEmpty && !predefinedAmounts.any((a) => a["amount"].toString() == selectedAmount) ? selectedAmount : "",
          onChanged: (value) {
            selectedAmount = value;
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        // Select Design
        Text(
          "Select Design",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: giftCardDesigns.map((design) {
            final isSelected = selectedDesign == design["id"];
            return GestureDetector(
              onTap: () {
                selectedDesign = design["id"] as int;
                setState(() {});
              },
              child: Container(
                width: 150,
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 3 : 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                        image: DecorationImage(
                          image: NetworkImage("${design["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      child: Text(
                        "${design["name"]}",
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? primaryColor : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: spLg),

        // Recipient Information
        Text(
          "Recipient Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        QTextField(
          label: "Recipient Name",
          value: recipientName,
          onChanged: (value) {
            recipientName = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QTextField(
          label: "Recipient Email",
          value: recipientEmail,
          onChanged: (value) {
            recipientEmail = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QTextField(
          label: "Your Name",
          value: senderName,
          onChanged: (value) {
            senderName = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QMemoField(
          label: "Personal Message (Optional)",
          value: personalMessage,
          onChanged: (value) {
            personalMessage = value;
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        // Delivery Date
        Text(
          "Delivery Date",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        QDatePicker(
          label: "Delivery Date",
          value: deliveryDate,
          onChanged: (value) {
            deliveryDate = value;
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        // Purchase Summary
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Purchase Summary",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gift Card Value:"),
                  Text(
                    "\$${selectedAmount.isNotEmpty ? double.tryParse(selectedAmount)?.toStringAsFixed(2) ?? "0.00" : "0.00"}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              if (selectedAmount.isNotEmpty && predefinedAmounts.any((a) => a["amount"].toString() == selectedAmount)) ...[
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bonus Amount:", style: TextStyle(color: successColor)),
                    Text(
                      "+\$${(predefinedAmounts.firstWhere((a) => a["amount"].toString() == selectedAmount)["bonus"] as double).toStringAsFixed(2)}",
                      style: TextStyle(color: successColor, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "\$${selectedAmount.isNotEmpty ? double.tryParse(selectedAmount)?.toStringAsFixed(2) ?? "0.00" : "0.00"}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: spLg),

        // Purchase Button
        Container(
          width: double.infinity,
          child: QButton(
            label: "Purchase Gift Card",
            size: bs.md,
            onPressed: selectedAmount.isNotEmpty && recipientName.isNotEmpty && recipientEmail.isNotEmpty && senderName.isNotEmpty ? () {
              // Process purchase
              ss("Gift card purchased successfully!");
            } : null,
          ),
        ),
      ],
    );
  }

  Widget _buildRedeemCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: successColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: successColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.redeem, size: 40, color: successColor),
              SizedBox(height: spSm),
              Text(
                "Redeem Gift Card",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Enter your gift card code to add credit to your account",
                style: TextStyle(
                  fontSize: 14,
                  color: successColor,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spLg),

        Text(
          "Gift Card Code",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        QTextField(
          label: "Enter Gift Card Code",
          value: giftCardCode,
          hint: "e.g., GC2024001",
          onChanged: (value) {
            giftCardCode = value.toUpperCase();
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        // Redeem Button
        Container(
          width: double.infinity,
          child: QButton(
            label: "Redeem Gift Card",
            size: bs.md,
            onPressed: giftCardCode.isNotEmpty ? () {
              // Process redemption
              ss("Gift card redeemed successfully!");
            } : null,
          ),
        ),

        SizedBox(height: spLg),

        // How to Redeem
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How to Redeem:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: spSm),
              _buildHowToStep("1", "Enter your gift card code above"),
              _buildHowToStep("2", "Click 'Redeem Gift Card' button"),
              _buildHowToStep("3", "Credit will be added to your account"),
              _buildHowToStep("4", "Use credit when booking services"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHowToStep(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats
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
                      "${myGiftCards.length}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Cards",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${myGiftCards.fold(0.0, (sum, card) => sum + (card["balance"] as double)).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Total Balance",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spLg),

        Text(
          "My Gift Cards",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),

        ...myGiftCards.map((card) {
          final isActive = card["status"] == "Active";
          final balance = card["balance"] as double;
          final amount = card["amount"] as double;
          final usedPercentage = ((amount - balance) / amount * 100).round();

          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: isActive ? successColor : disabledOutlineBorderColor,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isActive ? successColor.withAlpha(30) : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${card["status"]}",
                        style: TextStyle(
                          color: isActive ? successColor : disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${card["design"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Code: ${card["code"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\$${balance.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: isActive ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spLg),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Original Amount",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\$${amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                if (isActive && balance > 0) ...[
                  LinearProgressIndicator(
                    value: balance / amount,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${((balance / amount) * 100).round()}% remaining",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Purchased: ${card["purchaseDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Expires: ${card["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
