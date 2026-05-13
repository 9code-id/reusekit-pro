import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaContactlessPaymentView extends StatefulWidget {
  const BfaContactlessPaymentView({super.key});

  @override
  State<BfaContactlessPaymentView> createState() => _BfaContactlessPaymentViewState();
}

class _BfaContactlessPaymentViewState extends State<BfaContactlessPaymentView> {
  bool nfcEnabled = true;
  bool tapToPayEnabled = true;
  double dailyLimit = 500000.0;
  double singleTransactionLimit = 100000.0;
  String defaultCard = "main_card";
  
  List<Map<String, dynamic>> cards = [
    {
      "id": "main_card",
      "name": "Main Card",
      "number": "**** 1234",
      "type": "Debit",
      "balance": 2500000.0,
      "enabled": true,
    },
    {
      "id": "credit_card",
      "name": "Premium Credit",
      "number": "**** 5678",
      "type": "Credit",
      "limit": 10000000.0,
      "enabled": false,
    },
  ];
  
  List<Map<String, dynamic>> recentTransactions = [
    {
      "merchant": "Starbucks Coffee",
      "amount": 45000.0,
      "date": "2024-06-15 14:30",
      "type": "Contactless Payment",
      "status": "Success"
    },
    {
      "merchant": "McDonald's",
      "amount": 72000.0,
      "date": "2024-06-15 12:15",
      "type": "Tap to Pay",
      "status": "Success"
    },
    {
      "merchant": "Supermarket",
      "amount": 156000.0,
      "date": "2024-06-14 18:45",
      "type": "Contactless Payment",
      "status": "Success"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contactless Payment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NFC Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: nfcEnabled 
                    ? [primaryColor, primaryColor.withAlpha(200)]
                    : [disabledColor, disabledBoldColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    nfcEnabled ? Icons.nfc : Icons.nfc_outlined,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    nfcEnabled ? "NFC Ready" : "NFC Disabled",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    nfcEnabled 
                      ? "Tap your phone to pay at supported merchants"
                      : "Enable NFC to use contactless payments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quick Settings
            Text(
              "Quick Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.nfc, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enable NFC",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Required for contactless payments",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: nfcEnabled,
                        onChanged: (value) {
                          nfcEnabled = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.touch_app, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tap to Pay",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Enable quick tap payments",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: tapToPayEnabled,
                        onChanged: nfcEnabled ? (value) {
                          tapToPayEnabled = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Default Card Selection
            Text(
              "Default Payment Card",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: cards.map((card) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: defaultCard == card["id"] ? primaryColor : Colors.grey.shade300,
                      width: defaultCard == card["id"] ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 35,
                        decoration: BoxDecoration(
                          color: card["type"] == "Credit" ? warningColor : primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          card["type"] == "Credit" ? Icons.credit_card : Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${card["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${card["number"]} • ${card["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: card["id"],
                        groupValue: defaultCard,
                        onChanged: (value) {
                          defaultCard = value!;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Transaction Limits
            Text(
              "Transaction Limits",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Daily Limit",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "\$${(dailyLimit.toDouble()).currency}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: primaryColor),
                        onPressed: () {
                          _showLimitEditor("Daily Limit", dailyLimit, (value) {
                            dailyLimit = value;
                            setState(() {});
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Single Transaction Limit",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "\$${(singleTransactionLimit.toDouble()).currency}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: primaryColor),
                        onPressed: () {
                          _showLimitEditor("Single Transaction Limit", singleTransactionLimit, (value) {
                            singleTransactionLimit = value;
                            setState(() {});
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Recent Transactions
            Row(
              children: [
                Text(
                  "Recent Contactless Payments",
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
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.contactless,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${transaction["merchant"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${transaction["type"]} • ${transaction["date"]}",
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
                            "-\$${((transaction["amount"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
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

  void _showLimitEditor(String title, double currentValue, Function(double) onChanged) {
    String value = currentValue.toInt().toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "Amount",
              value: value,
              onChanged: (newValue) {
                value = newValue;
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
            label: "Save",
            size: bs.sm,
            onPressed: () {
              double newValue = double.tryParse(value) ?? currentValue;
              onChanged(newValue);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
