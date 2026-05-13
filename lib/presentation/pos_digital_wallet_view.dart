import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosDigitalWalletView extends StatefulWidget {
  const PosDigitalWalletView({super.key});

  @override
  State<PosDigitalWalletView> createState() => _PosDigitalWalletViewState();
}

class _PosDigitalWalletViewState extends State<PosDigitalWalletView> {
  String selectedWallet = "";
  bool isProcessing = false;
  String paymentStatus = "";
  
  final List<Map<String, dynamic>> digitalWallets = [
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.phone_iphone,
      "color": primaryColor,
      "description": "Pay with Touch ID or Face ID",
      "available": true,
      "setup_required": false,
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.android,
      "color": successColor,
      "description": "Pay with fingerprint or PIN",
      "available": true,
      "setup_required": false,
    },
    {
      "id": "samsung_pay",
      "name": "Samsung Pay",
      "icon": Icons.phone_android,
      "color": infoColor,
      "description": "Pay with Samsung devices",
      "available": false,
      "setup_required": true,
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.account_balance_wallet,
      "color": warningColor,
      "description": "Pay with PayPal account",
      "available": true,
      "setup_required": false,
    },
    {
      "id": "venmo",
      "name": "Venmo",
      "icon": Icons.payment,
      "color": secondaryColor,
      "description": "Pay with Venmo account",
      "available": true,
      "setup_required": true,
    },
    {
      "id": "cash_app",
      "name": "Cash App",
      "icon": Icons.monetization_on,
      "color": dangerColor,
      "description": "Pay with Cash App",
      "available": true,
      "setup_required": false,
    },
  ];

  double totalAmount = 126.85;
  double processingFee = 1.90;
  double finalAmount = 128.75;

  final List<Map<String, dynamic>> recentTransactions = [
    {
      "wallet": "Apple Pay",
      "amount": 42.50,
      "time": "1 minute ago",
      "status": "completed",
    },
    {
      "wallet": "Google Pay",
      "amount": 15.75,
      "time": "3 minutes ago",
      "status": "completed",
    },
    {
      "wallet": "PayPal",
      "amount": 89.20,
      "time": "10 minutes ago",
      "status": "completed",
    },
  ];

  void _selectWallet(String walletId) {
    selectedWallet = walletId;
    setState(() {});
  }

  void _setupWallet(String walletId) async {
    final wallet = digitalWallets.firstWhere((w) => w["id"] == walletId);
    
    si("Redirecting to ${wallet["name"]} setup...");
    
    // Simulate setup process
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    
    ss("${wallet["name"]} setup completed");
    
    // Update wallet availability
    final index = digitalWallets.indexWhere((w) => w["id"] == walletId);
    digitalWallets[index]["setup_required"] = false;
    setState(() {});
  }

  void _processWalletPayment() async {
    if (selectedWallet.isEmpty) {
      se("Please select a digital wallet");
      return;
    }

    final wallet = digitalWallets.firstWhere((w) => w["id"] == selectedWallet);
    
    if (!(wallet["available"] as bool)) {
      se("Selected wallet is not available");
      return;
    }

    if (wallet["setup_required"] as bool) {
      bool setupConfirmed = await confirm("${wallet["name"]} requires setup. Continue?");
      if (setupConfirmed) {
        _setupWallet(selectedWallet);  
      }
      return;
    }

    bool isConfirmed = await confirm(
      "Process ${wallet["name"]} payment of \$${finalAmount.currency}?"
    );
    
    if (!isConfirmed) return;

    setState(() {
      isProcessing = true;
      paymentStatus = "Connecting to ${wallet["name"]}...";
    });

    // Simulate connection
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      paymentStatus = "Waiting for authentication...";
    });

    // Simulate authentication
    await Future.delayed(Duration(seconds: 3));
    
    setState(() {
      paymentStatus = "Processing payment...";
    });

    // Simulate processing
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isProcessing = false;
      paymentStatus = "";
    });

    ss("${wallet["name"]} payment completed successfully");
    //navigateTo('payment_confirmation')
  }

  void _cancelPayment() async {
    if (isProcessing) {
      bool isConfirmed = await confirm("Cancel the payment process?");
      if (isConfirmed) {
        setState(() {
          isProcessing = false;
          paymentStatus = "";
        });
        si("Payment cancelled");
      }
    } else {
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Digital Wallet"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Select your preferred digital wallet to complete payment");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Payment Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
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
                        "Subtotal",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${totalAmount.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Processing Fee",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${processingFee.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${finalAmount.currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Processing Status
            if (isProcessing)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      paymentStatus,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Please complete the authentication on your device",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Digital Wallets Grid
            if (!isProcessing)
              Container(
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
                      "Select Digital Wallet",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 160,
                      children: digitalWallets.map((wallet) {
                        final isSelected = selectedWallet == wallet["id"];
                        final isAvailable = wallet["available"] as bool;
                        final requiresSetup = wallet["setup_required"] as bool;
                        
                        return GestureDetector(
                          onTap: isAvailable ? () => _selectWallet("${wallet["id"]}") : null,
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isSelected 
                                ? (wallet["color"] as Color).withValues(alpha: 0.1)
                                : isAvailable 
                                  ? Colors.white 
                                  : disabledColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: isSelected 
                                  ? wallet["color"] as Color
                                  : isAvailable 
                                    ? disabledOutlineBorderColor
                                    : disabledColor,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              spacing: spSm,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isAvailable 
                                      ? (wallet["color"] as Color).withValues(alpha: 0.1)
                                      : disabledColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    wallet["icon"] as IconData,
                                    color: isAvailable 
                                      ? wallet["color"] as Color
                                      : disabledBoldColor,
                                    size: 24,
                                  ),
                                ),
                                
                                Text(
                                  "${wallet["name"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isAvailable 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                  ),
                                ),
                                
                                Text(
                                  "${wallet["description"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                if (requiresSetup)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "SETUP REQUIRED",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: warningColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                
                                if (!isAvailable)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "UNAVAILABLE",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
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

            // Recent Transactions
            if (!isProcessing)
              Container(
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
                      "Recent Wallet Transactions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...List.generate(recentTransactions.length, (index) {
                      final transaction = recentTransactions[index];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${transaction["wallet"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${transaction["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Text(
                              "\$${(transaction["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

            // Wallet Features
            if (!isProcessing)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: infoColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Digital Wallet Benefits",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Faster checkout with biometric authentication\n• Secure tokenized payments\n• No need to enter card details\n• Works with most smartphones\n• Lower processing fees than traditional cards",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: isProcessing ? "Cancel Processing" : "Cancel",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: _cancelPayment,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: isProcessing 
                      ? "Processing..."
                      : selectedWallet.isEmpty
                        ? "Select Wallet"
                        : "Process Payment",
                    size: bs.md,
                    onPressed: isProcessing 
                      ? null 
                      : selectedWallet.isEmpty
                        ? null
                        : _processWalletPayment,
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
