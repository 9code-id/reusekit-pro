import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCardPaymentView extends StatefulWidget {
  const PosCardPaymentView({super.key});

  @override
  State<PosCardPaymentView> createState() => _PosCardPaymentViewState();
}

class _PosCardPaymentViewState extends State<PosCardPaymentView> {
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardHolderName = "";
  String cardType = "credit";
  bool saveCard = false;
  bool isProcessing = false;
  
  final List<Map<String, dynamic>> cardTypes = [
    {"label": "Credit Card", "value": "credit"},
    {"label": "Debit Card", "value": "debit"},
  ];

  final List<Map<String, dynamic>> savedCards = [
    {
      "id": "card_1",
      "last_four": "4532",
      "brand": "Visa",
      "type": "Credit",
      "name": "John Doe",
      "expiry": "12/25",
    },
    {
      "id": "card_2", 
      "last_four": "8901",
      "brand": "Mastercard",
      "type": "Debit",
      "name": "John Doe",
      "expiry": "08/26",
    },
  ];

  double totalAmount = 126.85;
  double processingFee = 3.17;
  double finalAmount = 129.02;

  String selectedSavedCard = "";
  String paymentStatus = "";

  bool get isValidCard {
    return cardNumber.length >= 13 && 
           expiryDate.length == 5 && 
           cvv.length >= 3 && 
           cardHolderName.isNotEmpty;
  }

  String _formatCardNumber(String value) {
    value = value.replaceAll(' ', '');
    String formatted = '';
    for (int i = 0; i < value.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += value[i];
    }
    return formatted;
  }

  String _formatExpiryDate(String value) {
    value = value.replaceAll('/', '');
    if (value.length >= 2) {
      return value.substring(0, 2) + '/' + value.substring(2);
    }
    return value;
  }

  String _detectCardBrand(String cardNumber) {
    String cleanNumber = cardNumber.replaceAll(' ', '');
    if (cleanNumber.startsWith('4')) return 'Visa';
    if (cleanNumber.startsWith('5')) return 'Mastercard';
    if (cleanNumber.startsWith('3')) return 'American Express';
    if (cleanNumber.startsWith('6')) return 'Discover';
    return 'Unknown';
  }

  void _selectSavedCard(String cardId) {
    selectedSavedCard = cardId;
    
    final card = savedCards.firstWhere((c) => c["id"] == cardId);
    cardHolderName = "${card["name"]}";
    
    setState(() {});
  }

  void _processCardPayment() async {
    if (selectedSavedCard.isEmpty && !isValidCard) {
      se("Please enter valid card details or select a saved card");
      return;
    }

    bool isConfirmed = await confirm(
      "Process card payment of \$${finalAmount.currency}?"
    );
    
    if (!isConfirmed) return;

    setState(() {
      isProcessing = true;
      paymentStatus = "Authorizing...";
    });

    // Simulate authorization
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      paymentStatus = "Processing payment...";
    });

    // Simulate processing
    await Future.delayed(Duration(seconds: 3));
    
    setState(() {
      paymentStatus = "Finalizing transaction...";
    });

    // Simulate finalization
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isProcessing = false;
      paymentStatus = "";
    });

    ss("Card payment processed successfully");
    
    if (saveCard && selectedSavedCard.isEmpty) {
      si("Card saved for future use");
    }
    
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
        title: Text("Card Payment"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {
              si("All card data is encrypted and secure");
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Please wait while we process your payment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Saved Cards
            if (!isProcessing && savedCards.isNotEmpty)
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
                      "Saved Cards",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...List.generate(savedCards.length, (index) {
                      final card = savedCards[index];
                      final isSelected = selectedSavedCard == card["id"];
                      
                      return GestureDetector(
                        onTap: () => _selectSavedCard("${card["id"]}"),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected 
                              ? primaryColor.withValues(alpha: 0.1)
                              : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected 
                                ? primaryColor
                                : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Center(
                                  child: Text(
                                    "${card["brand"]}".substring(0, 1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${card["brand"]} •••• ${card["last_four"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${card["name"]} • ${card["type"]} • ${card["expiry"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

            // Card Details Form
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedSavedCard.isEmpty ? "Enter Card Details" : "New Card",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (selectedSavedCard.isNotEmpty)
                          QButton(
                            label: "Clear Selection",
                            color: disabledBoldColor,
                            size: bs.sm,
                            onPressed: () {
                              selectedSavedCard = "";
                              setState(() {});
                            },
                          ),
                      ],
                    ),

                    QDropdownField(
                      label: "Card Type",
                      items: cardTypes,
                      value: cardType,
                      onChanged: (value, label) {
                        cardType = value;
                        setState(() {});
                      },
                    ),

                    QTextField(
                      label: "Card Number",
                      value: cardNumber,
                      hint: "1234 5678 9012 3456",
                      onChanged: (value) {
                        cardNumber = _formatCardNumber(value);
                        setState(() {});
                      },
                    ),

                    if (cardNumber.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Detected: ${_detectCardBrand(cardNumber)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Expiry Date",
                            value: expiryDate,
                            hint: "MM/YY",
                            onChanged: (value) {
                              expiryDate = _formatExpiryDate(value);
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "CVV",
                            value: cvv,
                            hint: "123",
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
                      value: cardHolderName,
                      hint: "John Doe",
                      onChanged: (value) {
                        cardHolderName = value;
                        setState(() {});
                      },
                    ),

                    if (selectedSavedCard.isEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: QSwitch(
                              items: [
                                {
                                  "label": "Save card for future use",
                                  "value": true,
                                  "checked": saveCard,
                                }
                              ],
                              value: [
                                if (saveCard)
                                  {
                                    "label": "Save card for future use",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                saveCard = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

            // Security Information
            if (!isProcessing)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: successColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Secure Payment",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Your card information is encrypted and secure\n• We comply with PCI DSS standards\n• Card details are not stored on our servers\n• Transaction is processed through secure channels",
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
                      : (selectedSavedCard.isNotEmpty || isValidCard)
                        ? "Process Payment"
                        : "Enter Card Details",
                    size: bs.md,
                    onPressed: isProcessing 
                      ? null 
                      : (selectedSavedCard.isNotEmpty || isValidCard)
                        ? _processCardPayment
                        : null,
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
