import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPaymentMethodsView extends StatefulWidget {
  const PosPaymentMethodsView({super.key});

  @override
  State<PosPaymentMethodsView> createState() => _PosPaymentMethodsViewState();
}

class _PosPaymentMethodsViewState extends State<PosPaymentMethodsView> {
  String selectedPaymentMethod = "";
  
  final List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "cash",
      "name": "Cash",
      "icon": Icons.payments,
      "color": successColor,
      "description": "Pay with cash",
      "processing_fee": 0.0,
      "available": true,
    },
    {
      "id": "card",
      "name": "Credit/Debit Card",
      "icon": Icons.credit_card,
      "color": primaryColor,
      "description": "Pay with card",
      "processing_fee": 2.5,
      "available": true,
    },
    {
      "id": "digital_wallet",
      "name": "Digital Wallet",
      "icon": Icons.phone_android,
      "color": infoColor,
      "description": "Apple Pay, Google Pay, etc.",
      "processing_fee": 1.5,
      "available": true,
    },
    {
      "id": "gift_card",
      "name": "Gift Card",
      "icon": Icons.card_giftcard,
      "color": warningColor,
      "description": "Redeem gift card",
      "processing_fee": 0.0,
      "available": true,
    },
    {
      "id": "store_credit",
      "name": "Store Credit",
      "icon": Icons.account_balance_wallet,
      "color": secondaryColor,
      "description": "Use store credit",
      "processing_fee": 0.0,
      "available": false,
    },
    {
      "id": "split_payment",
      "name": "Split Payment",
      "icon": Icons.call_split,
      "color": dangerColor,
      "description": "Multiple payment methods",
      "processing_fee": 0.0,
      "available": true,
    },
  ];

  double totalAmount = 126.85;
  double processingFee = 0.0;
  double finalAmount = 126.85;

  final List<Map<String, dynamic>> recentTransactions = [
    {
      "method": "Credit Card",
      "amount": 45.20,
      "time": "2 minutes ago",
      "status": "completed",
    },
    {
      "method": "Cash",
      "amount": 12.50,
      "time": "5 minutes ago", 
      "status": "completed",
    },
    {
      "method": "Digital Wallet",
      "amount": 78.90,
      "time": "8 minutes ago",
      "status": "completed",
    },
  ];

  void _selectPaymentMethod(String methodId) {
    selectedPaymentMethod = methodId;
    
    final method = paymentMethods.firstWhere((m) => m["id"] == methodId);
    processingFee = (method["processing_fee"] as double) * totalAmount / 100;
    finalAmount = totalAmount + processingFee;
    
    setState(() {});
  }

  void _proceedWithPayment() async {
    if (selectedPaymentMethod.isEmpty) {
      se("Please select a payment method");
      return;
    }

    final method = paymentMethods.firstWhere((m) => m["id"] == selectedPaymentMethod);
    
    if (!(method["available"] as bool)) {
      se("Selected payment method is not available");
      return;
    }

    bool isConfirmed = await confirm("Proceed with ${method["name"]} payment?");
    if (isConfirmed) {
      ss("Redirecting to ${method["name"]} payment");
      
      switch (selectedPaymentMethod) {
        case "cash":
          //navigateTo('cash_payment')
          break;
        case "card":
          //navigateTo('card_payment')
          break;
        case "digital_wallet":
          //navigateTo('digital_wallet_payment')
          break;
        case "split_payment":
          //navigateTo('split_payment')
          break;
        default:
          si("Processing ${method["name"]} payment...");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              si("View payment history");
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
                  
                  if (processingFee > 0) ...[
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
                  ],
                  
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

            // Payment Methods Grid
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
                    "Select Payment Method",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 160,
                    children: paymentMethods.map((method) {
                      final isSelected = selectedPaymentMethod == method["id"];
                      final isAvailable = method["available"] as bool;
                      final processingFeePercent = method["processing_fee"] as double;
                      
                      return GestureDetector(
                        onTap: isAvailable ? () => _selectPaymentMethod("${method["id"]}") : null,
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSelected 
                              ? (method["color"] as Color).withValues(alpha: 0.1)
                              : isAvailable 
                                ? Colors.white 
                                : disabledColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: isSelected 
                                ? method["color"] as Color
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
                                    ? (method["color"] as Color).withValues(alpha: 0.1)
                                    : disabledColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  method["icon"] as IconData,
                                  color: isAvailable 
                                    ? method["color"] as Color
                                    : disabledBoldColor,
                                  size: 24,
                                ),
                              ),
                              
                              Text(
                                "${method["name"]}",
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
                                "${method["description"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              if (processingFeePercent > 0)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${processingFeePercent}% fee",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
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
                    "Recent Transactions",
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
                                  "${transaction["method"]}",
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

            // Payment Tips
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
                        "Payment Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Cash payments have no processing fees\n• Digital wallets process faster than cards\n• Split payments allow multiple methods\n• Processing fees are calculated automatically",
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
                    label: "Cancel Transaction",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Cancel this transaction?");
                      if (isConfirmed) {
                        back();
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: selectedPaymentMethod.isEmpty 
                      ? "Select Payment Method"
                      : "Proceed to Payment",
                    size: bs.md,
                    onPressed: selectedPaymentMethod.isEmpty ? null : _proceedWithPayment,
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
