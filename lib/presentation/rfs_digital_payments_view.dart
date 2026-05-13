import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsDigitalPaymentsView extends StatefulWidget {
  const RfsDigitalPaymentsView({super.key});

  @override
  State<RfsDigitalPaymentsView> createState() => _RfsDigitalPaymentsViewState();
}

class _RfsDigitalPaymentsViewState extends State<RfsDigitalPaymentsView> {
  int selectedTab = 0;
  String selectedPaymentMethod = "Apple Pay";
  String qrAmount = "";
  String cryptoWallet = "";
  bool autoAcceptPayments = true;
  bool enableNotifications = true;

  List<Map<String, dynamic>> digitalPayments = [
    {
      "id": "DIG001",
      "method": "Apple Pay",
      "amount": 24.50,
      "customerName": "Alex Johnson",
      "timestamp": "2024-06-19 15:45",
      "status": "Completed",
      "deviceId": "iPhone 13 Pro",
      "table": "Table 7"
    },
    {
      "id": "DIG002",
      "method": "Google Pay",
      "amount": 67.80,
      "customerName": "Maria Garcia",
      "timestamp": "2024-06-19 15:30",
      "status": "Completed",
      "deviceId": "Samsung Galaxy S23",
      "table": "Table 2"
    },
    {
      "id": "DIG003",
      "method": "PayPal",
      "amount": 89.25,
      "customerName": "David Chen",
      "timestamp": "2024-06-19 15:15",
      "status": "Pending",
      "deviceId": "Web Browser",
      "table": "Table 14"
    },
    {
      "id": "DIG004",
      "method": "QR Code",
      "amount": 156.40,
      "customerName": "Lisa Anderson",
      "timestamp": "2024-06-19 14:55",
      "status": "Completed",
      "deviceId": "Mobile App",
      "table": "Table 9"
    }
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Apple Pay", "value": "Apple Pay"},
    {"label": "Google Pay", "value": "Google Pay"},
    {"label": "Samsung Pay", "value": "Samsung Pay"},
    {"label": "PayPal", "value": "PayPal"},
    {"label": "Venmo", "value": "Venmo"},
    {"label": "QR Code", "value": "QR Code"}
  ];

  List<Map<String, dynamic>> cryptoOptions = [
    {"label": "Bitcoin (BTC)", "value": "BTC"},
    {"label": "Ethereum (ETH)", "value": "ETH"},
    {"label": "USD Coin (USDC)", "value": "USDC"},
    {"label": "Litecoin (LTC)", "value": "LTC"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Digital Payments",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Accept Payments", icon: Icon(Icons.qr_code)),
        Tab(text: "Payment History", icon: Icon(Icons.history)),
        Tab(text: "Digital Wallets", icon: Icon(Icons.account_balance_wallet)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildAcceptPaymentsTab(),
        _buildPaymentHistoryTab(),
        _buildDigitalWalletsTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildAcceptPaymentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Payment Methods
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
                  "Quick Payment Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 120,
                  children: [
                    _buildPaymentMethodCard("Apple Pay", Icons.phone_iphone, successColor),
                    _buildPaymentMethodCard("Google Pay", Icons.android, infoColor),
                    _buildPaymentMethodCard("Samsung Pay", Icons.smartphone, warningColor),
                    _buildPaymentMethodCard("PayPal", Icons.payment, primaryColor),
                    _buildPaymentMethodCard("QR Code", Icons.qr_code, secondaryColor),
                    _buildPaymentMethodCard("Crypto", Icons.currency_bitcoin, dangerColor),
                  ],
                ),
              ],
            ),
          ),

          // QR Code Payment
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
                  "Generate QR Code Payment",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Payment Amount (\$)",
                  value: qrAmount,
                  validator: Validator.required,
                  onChanged: (value) {
                    qrAmount = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code,
                          size: 80,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          qrAmount.isNotEmpty 
                              ? "QR Code for \$${qrAmount}"
                              : "Enter amount to generate QR code",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Generate QR Code",
                        size: bs.md,
                        onPressed: () {
                          if (qrAmount.isNotEmpty) {
                            ss("QR code generated for \$${qrAmount}");
                          } else {
                            se("Please enter payment amount");
                          }
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.refresh,
                      size: bs.md,
                      onPressed: () {
                        qrAmount = "";
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // NFC/Contactless
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
                Row(
                  children: [
                    Icon(Icons.nfc, color: infoColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NFC/Contactless Ready",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Tap device to accept payment",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        selectedPaymentMethod = title;
        si("${title} payment method selected");
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: selectedPaymentMethod == title ? color.withAlpha(20) : Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: selectedPaymentMethod == title ? color : disabledOutlineBorderColor,
            width: selectedPaymentMethod == title ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: selectedPaymentMethod == title ? color : disabledBoldColor,
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selectedPaymentMethod == title ? color : disabledBoldColor,
              ),
            ),
          ],
        ),
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
                      Icon(Icons.trending_up, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$337.95",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Digital Total",
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
                      Icon(Icons.phone_android, color: infoColor, size: 32),
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
          ...digitalPayments.map((payment) {
            Color statusColor = (payment["status"] as String) == "Completed" 
                ? successColor 
                : (payment["status"] as String) == "Pending" 
                    ? warningColor 
                    : dangerColor;
            
            IconData methodIcon = _getPaymentMethodIcon(payment["method"] as String);
            
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
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(methodIcon, size: 16, color: primaryColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${payment["id"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: disabledBoldColor,
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
                      Icon(Icons.smartphone, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${payment["method"]} • ${payment["deviceId"]}",
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

  Widget _buildDigitalWalletsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wallet Connections
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
                  "Connected Wallets",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildWalletItem("Apple Pay", Icons.phone_iphone, true, successColor),
                _buildWalletItem("Google Pay", Icons.android, true, infoColor),
                _buildWalletItem("Samsung Pay", Icons.smartphone, false, disabledBoldColor),
                _buildWalletItem("PayPal", Icons.payment, true, primaryColor),
              ],
            ),
          ),

          // Cryptocurrency Settings
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
                  "Cryptocurrency Payments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Preferred Crypto",
                  items: cryptoOptions,
                  value: cryptoWallet,
                  onChanged: (value, label) {
                    cryptoWallet = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Wallet Address",
                  value: "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa",
                  hint: "Enter your crypto wallet address",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Accept cryptocurrency payments",
                      "value": "crypto_enabled",
                      "checked": false,
                    }
                  ],
                  value: [],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Digital Wallet Features
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
                  "Wallet Features",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildFeatureItem("Instant Settlement", Icons.flash_on, true),
                _buildFeatureItem("Fraud Protection", Icons.security, true),
                _buildFeatureItem("Loyalty Integration", Icons.star, true),
                _buildFeatureItem("Receipt Auto-Send", Icons.email, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletItem(String name, IconData icon, bool connected, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: connected ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              connected ? "Connected" : "Not Connected",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: connected ? successColor : disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon, bool enabled) {
    return Row(
      children: [
        Icon(
          icon, 
          color: enabled ? primaryColor : disabledBoldColor, 
          size: 20
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: enabled ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
        Icon(
          enabled ? Icons.check_circle : Icons.radio_button_unchecked,
          color: enabled ? successColor : disabledBoldColor,
          size: 20,
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Processing
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
                  "Payment Processing",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Auto-accept digital payments",
                      "value": "auto_accept",
                      "checked": autoAcceptPayments,
                    },
                    {
                      "label": "Enable payment notifications",
                      "value": "notifications",
                      "checked": enableNotifications,
                    }
                  ],
                  value: [
                    if (autoAcceptPayments)
                      {"label": "Auto-accept digital payments", "value": "auto_accept", "checked": true},
                    if (enableNotifications)
                      {"label": "Enable payment notifications", "value": "notifications", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    autoAcceptPayments = values.any((v) => v["value"] == "auto_accept");
                    enableNotifications = values.any((v) => v["value"] == "notifications");
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
                  "Security & Limits",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Daily Transaction Limit (\$)",
                  value: "5000",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Single Transaction Limit (\$)",
                  value: "1000",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          QButton(
            label: "Save Digital Payment Settings",
            size: bs.md,
            onPressed: () {
              ss("Digital payment settings saved successfully!");
            },
          ),
        ],
      ),
    );
  }

  IconData _getPaymentMethodIcon(String method) {
    switch (method) {
      case "Apple Pay":
        return Icons.phone_iphone;
      case "Google Pay":
        return Icons.android;
      case "Samsung Pay":
        return Icons.smartphone;
      case "PayPal":
        return Icons.payment;
      case "QR Code":
        return Icons.qr_code;
      default:
        return Icons.account_balance_wallet;
    }
  }
}
