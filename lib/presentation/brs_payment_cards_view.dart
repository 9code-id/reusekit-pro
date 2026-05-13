import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPaymentCardsView extends StatefulWidget {
  const BrsPaymentCardsView({super.key});

  @override
  State<BrsPaymentCardsView> createState() => _BrsPaymentCardsViewState();
}

class _BrsPaymentCardsViewState extends State<BrsPaymentCardsView> {
  List<Map<String, dynamic>> paymentCards = [
    {
      "id": "1",
      "type": "Visa",
      "last4": "1234",
      "holderName": "John Doe",
      "expiryDate": "12/25",
      "isDefault": true,
      "color": Colors.blue,
    },
    {
      "id": "2",
      "type": "Mastercard",
      "last4": "5678",
      "holderName": "John Doe",
      "expiryDate": "08/26",
      "isDefault": false,
      "color": Colors.red,
    },
    {
      "id": "3",
      "type": "American Express",
      "last4": "9012",
      "holderName": "John Doe",
      "expiryDate": "03/27",
      "isDefault": false,
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Cards"),
        actions: [
          IconButton(
            onPressed: () => _addNewCard(),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: Colors.blue.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: Colors.blue,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Manage Payment Methods",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Add, edit, or remove your payment cards. Your card information is encrypted and secure.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "Saved Cards",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add New Card",
                  size: bs.sm,
                  icon: Icons.add,
                  onPressed: () => _addNewCard(),
                ),
              ],
            ),
            if (paymentCards.isEmpty)
              Container(
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.credit_card_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Payment Cards",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Add your first payment card to make quick and secure payments.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Add Payment Card",
                      size: bs.md,
                      onPressed: () => _addNewCard(),
                    ),
                  ],
                ),
              )
            else
              ...paymentCards.map((card) => _buildPaymentCard(card)),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Security Features",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildSecurityFeature(
                    "256-bit SSL Encryption",
                    "Your card details are protected with bank-level security",
                    Icons.security,
                  ),
                  _buildSecurityFeature(
                    "PCI DSS Compliant",
                    "We follow strict industry standards for payment security",
                    Icons.verified_user,
                  ),
                  _buildSecurityFeature(
                    "Zero Liability Protection",
                    "You're protected from unauthorized transactions",
                    Icons.shield,
                  ),
                  _buildSecurityFeature(
                    "No CVV Storage",
                    "We never store your card's security code",
                    Icons.privacy_tip,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> card) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  card["color"] as Color,
                  (card["color"] as Color).withAlpha(200),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.contactless,
                      color: Colors.white,
                      size: 24,
                    ),
                    Spacer(),
                    if (card["isDefault"])
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "DEFAULT",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "**** **** **** ${card["last4"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                    fontFamily: 'monospace',
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CARD HOLDER",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withAlpha(200),
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: spXxs),
                        Text(
                          "${card["holderName"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EXPIRES",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withAlpha(200),
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: spXxs),
                        Text(
                          "${card["expiryDate"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "${card["type"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusLg)),
            ),
            child: Row(
              children: [
                if (!card["isDefault"])
                  QButton(
                    label: "Set Default",
                    size: bs.sm,
                    onPressed: () => _setAsDefault(card),
                  ),
                if (!card["isDefault"])
                  SizedBox(width: spSm),
                QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () => _editCard(card),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Remove",
                  size: bs.sm,
                  onPressed: () => _removeCard(card),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getCardStatusColor(card).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: _getCardStatusColor(card).withAlpha(30)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _getCardStatusColor(card),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        _getCardStatus(card),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getCardStatusColor(card),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityFeature(String title, String description, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            color: successColor,
            size: 16,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXxs),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getCardStatusColor(Map<String, dynamic> card) {
    DateTime expiry = DateTime.parse("20${card["expiryDate"].split('/')[1]}-${card["expiryDate"].split('/')[0]}-01");
    DateTime now = DateTime.now();
    
    if (expiry.isBefore(now)) {
      return dangerColor;
    } else if (expiry.difference(now).inDays < 30) {
      return warningColor;
    } else {
      return successColor;
    }
  }

  String _getCardStatus(Map<String, dynamic> card) {
    DateTime expiry = DateTime.parse("20${card["expiryDate"].split('/')[1]}-${card["expiryDate"].split('/')[0]}-01");
    DateTime now = DateTime.now();
    
    if (expiry.isBefore(now)) {
      return "Expired";
    } else if (expiry.difference(now).inDays < 30) {
      return "Expires Soon";
    } else {
      return "Active";
    }
  }

  void _addNewCard() {
    ss("Add new card screen opened");
    // ss('Next page'));
  }

  void _setAsDefault(Map<String, dynamic> card) async {
    bool isConfirmed = await confirm("Set this card as your default payment method?");
    if (isConfirmed) {
      for (var c in paymentCards) {
        c["isDefault"] = false;
      }
      card["isDefault"] = true;
      setState(() {});
      ss("Default payment method updated");
    }
  }

  void _editCard(Map<String, dynamic> card) {
    ss("Edit card screen opened");
  }

  void _removeCard(Map<String, dynamic> card) async {
    if (card["isDefault"]) {
      se("Cannot remove default payment method. Set another card as default first.");
      return;
    }
    
    bool isConfirmed = await confirm("Remove this payment card? This action cannot be undone.");
    if (isConfirmed) {
      paymentCards.removeWhere((c) => c["id"] == card["id"]);
      setState(() {});
      ss("Payment card removed successfully");
    }
  }
}
