import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsRedeemGiftCardView extends StatefulWidget {
  const EcsRedeemGiftCardView({super.key});

  @override
  State<EcsRedeemGiftCardView> createState() => _EcsRedeemGiftCardViewState();
}

class _EcsRedeemGiftCardViewState extends State<EcsRedeemGiftCardView> {
  String giftCardCode = "";
  String recipientEmail = "";
  bool isCodeValid = false;
  
  List<Map<String, dynamic>> myGiftCards = [
    {
      "id": "GC001",
      "amount": 50.0,
      "balance": 50.0,
      "code": "GIFT50-XYZAB-12345",
      "expiryDate": "2024-12-31",
      "from": "John Doe",
      "message": "Happy Birthday! Enjoy shopping!",
      "status": "Active",
      "usedAmount": 0.0,
    },
    {
      "id": "GC002", 
      "amount": 100.0,
      "balance": 25.0,
      "code": "GIFT100-ABCDE-67890",
      "expiryDate": "2025-03-15",
      "from": "Sarah Wilson",
      "message": "Congratulations on your graduation!",
      "status": "Partially Used",
      "usedAmount": 75.0,
    },
    {
      "id": "GC003",
      "amount": 25.0,
      "balance": 0.0,
      "code": "GIFT25-MNOPQ-54321",
      "expiryDate": "2024-06-30",
      "from": "Emily Johnson",
      "message": "Thank you for being an amazing friend!",
      "status": "Used",
      "usedAmount": 25.0,
    },
  ];

  List<Map<String, dynamic>> redeemHistory = [
    {
      "date": "2024-01-15",
      "code": "GIFT100-ABCDE-67890",
      "amount": 75.0,
      "orderNumber": "ORD-2024-001",
      "description": "Redeemed for Electronics purchase",
    },
    {
      "date": "2024-01-10",
      "code": "GIFT25-MNOPQ-54321", 
      "amount": 25.0,
      "orderNumber": "ORD-2024-002",
      "description": "Redeemed for Fashion items",
    },
  ];

  void _validateGiftCard() {
    if (giftCardCode.length >= 10) {
      setState(() {
        isCodeValid = true;
      });
      ss("Gift card code validated successfully!");
    } else {
      se("Please enter a valid gift card code");
    }
  }

  void _redeemGiftCard() async {
    if (giftCardCode.isEmpty) {
      se("Please enter a gift card code");
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to redeem this gift card?");
    if (isConfirmed) {
      ss("Gift card redeemed successfully! \$50.00 added to your wallet.");
      setState(() {
        giftCardCode = "";
        isCodeValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Gift Card"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to redeem history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gift Card Redemption Form
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
                children: [
                  Text(
                    "Enter Gift Card Code",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Enter your gift card code to redeem it and add the balance to your wallet.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Gift Card Code",
                    value: giftCardCode,
                    hint: "Enter your gift card code",
                    onChanged: (value) {
                      giftCardCode = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Validate Code",
                          size: bs.sm,
                          onPressed: _validateGiftCard,
                        ),
                      ),
                      SizedBox(width: spSm),
                      if (isCodeValid)
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                    ],
                  ),
                  if (isCodeValid) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gift Card Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text("Amount: \$50.00"),
                          Text("From: John Doe"),
                          Text("Message: Happy Shopping!"),
                          Text("Expires: December 31, 2024"),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Redeem Gift Card",
                        onPressed: _redeemGiftCard,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // My Gift Cards Section
            Text(
              "My Gift Cards",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Gift Cards List
            ...myGiftCards.map((card) {
              Color statusColor = card["status"] == "Active" 
                  ? successColor 
                  : card["status"] == "Partially Used" 
                      ? warningColor 
                      : disabledBoldColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${(card["balance"] as double).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${card["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Code: ${card["code"]}",
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "From: ${card["from"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Expires: ${card["expiryDate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    if (card["message"].isNotEmpty) ...[
                      SizedBox(height: spXs),
                      Text(
                        "\"${card["message"]}\"",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                    if (card["status"] == "Partially Used") ...[
                      SizedBox(height: spSm),
                      LinearProgressIndicator(
                        value: (card["balance"] as double) / (card["amount"] as double),
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(successColor),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Used: \$${(card["usedAmount"] as double).currency} of \$${(card["amount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Redemption History Section
            Text(
              "Redemption History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // History List
            ...redeemHistory.map((history) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.redeem,
                        color: successColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${(history["amount"] as double).currency} Redeemed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${history["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Order: ${history["orderNumber"]} • ${history["date"]}",
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
              );
            }).toList(),

            SizedBox(height: spMd),

            // Help Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "How to Redeem Gift Cards",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Enter your gift card code in the field above\n"
                    "• Validate the code to see gift card details\n"
                    "• Click 'Redeem' to add balance to your wallet\n"
                    "• Use the balance during checkout for purchases\n"
                    "• Check your redemption history anytime",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 14,
                    ),
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
