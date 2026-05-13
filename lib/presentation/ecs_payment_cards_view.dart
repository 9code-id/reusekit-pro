import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsPaymentCardsView extends StatefulWidget {
  const EcsPaymentCardsView({super.key});

  @override
  State<EcsPaymentCardsView> createState() => _EcsPaymentCardsViewState();
}

class _EcsPaymentCardsViewState extends State<EcsPaymentCardsView> {
  bool loading = false;
  int selectedCardIndex = 0;

  List<Map<String, dynamic>> paymentCards = [
    {
      "id": 1,
      "type": "visa",
      "number": "**** **** **** 1234",
      "holder_name": "John Doe",
      "expiry": "12/25",
      "is_default": true,
      "color": 0xFF1976D2,
    },
    {
      "id": 2,
      "type": "mastercard",
      "number": "**** **** **** 5678",
      "holder_name": "John Doe",
      "expiry": "08/26",
      "is_default": false,
      "color": 0xFFE53935,
    },
    {
      "id": 3,
      "type": "amex",
      "number": "**** **** **** 9012",
      "holder_name": "John Doe",
      "expiry": "03/27",
      "is_default": false,
      "color": 0xFF00ACC1,
    },
  ];

  void _setDefaultCard(int index) async {
    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    // Update default status
    for (int i = 0; i < paymentCards.length; i++) {
      paymentCards[i]["is_default"] = i == index;
    }

    loading = false;
    setState(() {});

    ss("Default card updated successfully");
  }

  void _deleteCard(int index) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this card?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    paymentCards.removeAt(index);

    loading = false;
    setState(() {});

    ss("Card deleted successfully");
  }

  void _addNewCard() async {
    
    // Refresh data after adding new card
    setState(() {});
  }

  String _getCardIcon(String type) {
    switch (type.toLowerCase()) {
      case 'visa':
        return '💳';
      case 'mastercard':
        return '💳';
      case 'amex':
        return '💳';
      default:
        return '💳';
    }
  }

  Widget _buildCardItem(Map<String, dynamic> card, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(card["color"] as int),
            Color(card["color"] as int).withAlpha(180),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getCardIcon("${card["type"]}"),
                  style: TextStyle(fontSize: 24),
                ),
                Row(
                  children: [
                    if (card["is_default"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Default",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () => _showCardOptions(card, index),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "${card["number"]}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Card Holder",
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${card["holder_name"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Expires",
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${card["expiry"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
  }

  void _showCardOptions(Map<String, dynamic> card, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            Text(
              "Card Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            if (!(card["is_default"] as bool))
              ListTile(
                leading: Icon(Icons.star, color: warningColor),
                title: Text("Set as Default"),
                onTap: () {
                  back();
                  _setDefaultCard(index);
                },
              ),
            
            ListTile(
              leading: Icon(Icons.edit, color: infoColor),
              title: Text("Edit Card"),
              onTap: () {
                back();
                // Navigate to edit card
              },
            ),
            
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Card"),
              onTap: () {
                back();
                _deleteCard(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Payment Cards"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Cards"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewCard,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Your payment information is encrypted and secure",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Cards List
            if (paymentCards.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.credit_card_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Payment Cards",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Add your first payment card to start shopping",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Add Payment Card",
                      size: bs.md,
                      onPressed: _addNewCard,
                    ),
                  ],
                ),
              )
            else
              Column(
                children: [
                  ...List.generate(paymentCards.length, (index) {
                    final card = paymentCards[index];
                    return _buildCardItem(card, index);
                  }),
                  
                  SizedBox(height: spMd),
                  
                  // Add New Card Button
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: GestureDetector(
                      onTap: _addNewCard,
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Add New Card",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
