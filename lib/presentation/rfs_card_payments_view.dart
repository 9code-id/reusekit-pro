import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsCardPaymentsView extends StatefulWidget {
  const RfsCardPaymentsView({super.key});

  @override
  State<RfsCardPaymentsView> createState() => _RfsCardPaymentsViewState();
}

class _RfsCardPaymentsViewState extends State<RfsCardPaymentsView> {
  String paymentType = "Credit Card";
  String amount = "";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  bool saveCard = false;
  int selectedTab = 0;

  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": "TXN001",
      "amount": 45.80,
      "cardType": "Visa",
      "last4": "4567",
      "customerName": "John Smith",
      "timestamp": "2024-06-19 14:30",
      "status": "Completed",
      "table": "Table 5"
    },
    {
      "id": "TXN002", 
      "amount": 78.50,
      "cardType": "Mastercard",
      "last4": "9876",
      "customerName": "Sarah Johnson",
      "timestamp": "2024-06-19 14:15",
      "status": "Completed",
      "table": "Table 12"
    },
    {
      "id": "TXN003",
      "amount": 32.25,
      "cardType": "American Express",
      "last4": "1234",
      "customerName": "Mike Davis",
      "timestamp": "2024-06-19 13:45",
      "status": "Failed",
      "table": "Table 3"
    },
    {
      "id": "TXN004",
      "amount": 125.90,
      "cardType": "Visa",
      "last4": "5678",
      "customerName": "Emily Wilson",
      "timestamp": "2024-06-19 13:20",
      "status": "Completed",
      "table": "Table 8"
    }
  ];

  List<Map<String, dynamic>> cardTypes = [
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Debit Card", "value": "Debit Card"},
    {"label": "Contactless", "value": "Contactless"},
    {"label": "Chip & PIN", "value": "Chip & PIN"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Card Payments",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Process Payment", icon: Icon(Icons.credit_card)),
        Tab(text: "Payment History", icon: Icon(Icons.history)),
        Tab(text: "Card Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildProcessPaymentTab(),
        _buildPaymentHistoryTab(),
        _buildCardSettingsTab(),
      ],
    );
  }

  Widget _buildProcessPaymentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Amount Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Amount",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Amount (\$)",
                  value: amount,
                  validator: Validator.required,
                  onChanged: (value) {
                    amount = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Payment Type",
                  items: cardTypes,
                  value: paymentType,
                  onChanged: (value, label) {
                    paymentType = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Card Information Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Card Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Card Number",
                  value: cardNumber,
                  hint: "1234 5678 9012 3456",
                  validator: Validator.required,
                  onChanged: (value) {
                    cardNumber = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Expiry Date",
                        value: expiryDate,
                        hint: "MM/YY",
                        validator: Validator.required,
                        onChanged: (value) {
                          expiryDate = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "CVV",
                        value: cvv,
                        hint: "123",
                        validator: Validator.required,
                        onChanged: (value) {
                          cvv = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Cardholder Name",
                  value: cardholderName,
                  validator: Validator.required,
                  onChanged: (value) {
                    cardholderName = value;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Save card for future payments",
                      "value": true,
                      "checked": saveCard,
                    }
                  ],
                  value: [
                    if (saveCard)
                      {"label": "Save card for future payments", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    saveCard = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Process Payment",
                  size: bs.md,
                  onPressed: () {
                    showLoading();
                    Future.delayed(Duration(seconds: 2), () {
                      hideLoading();
                      ss("Payment processed successfully!");
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.nfc,
                size: bs.md,
                onPressed: () {
                  si("Tap card on NFC reader");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Stats Cards
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
                      Icon(Icons.attach_money, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$282.45",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Today's Total",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                      Icon(Icons.credit_card, color: infoColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "4",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Transactions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Payment History List
          ...paymentHistory.map((payment) {
            Color statusColor = (payment["status"] as String) == "Completed" 
                ? successColor 
                : dangerColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: statusColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${payment["id"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${payment["customerName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(payment["amount"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${payment["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.credit_card, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${payment["cardType"]} •••• ${payment["last4"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${payment["table"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${payment["timestamp"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCardSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Terminal Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Terminal Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable contactless payments",
                      "value": "contactless",
                      "checked": true,
                    },
                    {
                      "label": "Enable chip & PIN",
                      "value": "chip_pin",
                      "checked": true,
                    },
                    {
                      "label": "Enable magnetic stripe",
                      "value": "mag_stripe",
                      "checked": false,
                    }
                  ],
                  value: [
                    {"label": "Enable contactless payments", "value": "contactless", "checked": true},
                    {"label": "Enable chip & PIN", "value": "chip_pin", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Security Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Security Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Require signature for transactions over \$25",
                      "value": "signature_required",
                      "checked": true,
                    },
                    {
                      "label": "Enable transaction limits",
                      "value": "transaction_limits",
                      "checked": true,
                    },
                    {
                      "label": "Require manager approval for refunds",
                      "value": "manager_approval",
                      "checked": true,
                    }
                  ],
                  value: [
                    {"label": "Require signature for transactions over \$25", "value": "signature_required", "checked": true},
                    {"label": "Enable transaction limits", "value": "transaction_limits", "checked": true},
                    {"label": "Require manager approval for refunds", "value": "manager_approval", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Fees & Processing
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Processing Fees",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.credit_card, color: disabledBoldColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Credit Card",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "2.9% + \$0.30",
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
                Divider(),
                Row(
                  children: [
                    Icon(Icons.payment, color: disabledBoldColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Debit Card",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "1.9% + \$0.25",
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

          QButton(
            label: "Save Settings",
            size: bs.md,
            onPressed: () {
              ss("Settings saved successfully!");
            },
          ),
        ],
      ),
    );
  }
}
