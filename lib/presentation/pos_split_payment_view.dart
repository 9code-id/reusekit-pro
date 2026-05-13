import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosSplitPaymentView extends StatefulWidget {
  const PosSplitPaymentView({super.key});

  @override
  State<PosSplitPaymentView> createState() => _PosSplitPaymentViewState();
}

class _PosSplitPaymentViewState extends State<PosSplitPaymentView> {
  double totalAmount = 126.85;
  
  final List<Map<String, dynamic>> paymentSplits = [
    {
      "id": "split_1",
      "method": "cash",
      "method_name": "Cash",
      "amount": 0.0,
      "status": "pending",
      "icon": Icons.payments,
      "color": successColor,
    },
    {
      "id": "split_2", 
      "method": "card",
      "method_name": "Credit Card",
      "amount": 0.0,
      "status": "pending",
      "icon": Icons.credit_card,
      "color": primaryColor,
    },
  ];

  final List<Map<String, dynamic>> availablePaymentMethods = [
    {
      "id": "cash",
      "name": "Cash",
      "icon": Icons.payments,
      "color": successColor,
    },
    {
      "id": "card",
      "name": "Credit/Debit Card",
      "icon": Icons.credit_card,
      "color": primaryColor,
    },
    {
      "id": "digital_wallet",
      "name": "Digital Wallet",
      "icon": Icons.phone_android,
      "color": infoColor,
    },
    {
      "id": "gift_card",
      "name": "Gift Card",
      "icon": Icons.card_giftcard,
      "color": warningColor,
    },
  ];

  String splitMode = "equal";
  int numberOfSplits = 2;
  String customSplitAmount = "";
  int selectedSplitIndex = 0;

  final List<Map<String, dynamic>> splitModes = [
    {"label": "Equal Split", "value": "equal"},
    {"label": "Custom Amount", "value": "custom"},
    {"label": "Percentage Split", "value": "percentage"},
  ];

  double get totalAssigned {
    return paymentSplits.fold(0.0, (sum, split) => sum + (split["amount"] as double));
  }

  double get remainingAmount {
    return totalAmount - totalAssigned;
  }

  bool get isValidSplit {
    return (totalAmount - totalAssigned).abs() < 0.01;
  }

  void _addPaymentSplit() {
    if (paymentSplits.length >= 5) {
      se("Maximum 5 payment methods allowed");
      return;
    }

    final newSplit = {
      "id": "split_${paymentSplits.length + 1}",
      "method": "cash",
      "method_name": "Cash",
      "amount": 0.0,
      "status": "pending",
      "icon": Icons.payments,
      "color": successColor,
    };

    paymentSplits.add(newSplit);
    _recalculateSplits();
  }

  void _removePaymentSplit(int index) {
    if (paymentSplits.length <= 1) {
      se("At least one payment method required");
      return;
    }

    paymentSplits.removeAt(index);
    _recalculateSplits();
  }

  void _updateSplitMethod(int index, String methodId) {
    final method = availablePaymentMethods.firstWhere((m) => m["id"] == methodId);
    
    paymentSplits[index]["method"] = methodId;
    paymentSplits[index]["method_name"] = "${method["name"]}";
    paymentSplits[index]["icon"] = method["icon"];
    paymentSplits[index]["color"] = method["color"];
    
    setState(() {});
  }

  void _updateSplitAmount(int index, double amount) {
    paymentSplits[index]["amount"] = amount;
    setState(() {});
  }

  void _recalculateSplits() {
    if (splitMode == "equal") {
      double equalAmount = totalAmount / paymentSplits.length;
      for (var split in paymentSplits) {
        split["amount"] = equalAmount;
      }
    }
    setState(() {});
  }

  void _processSplitPayment() async {
    if (!isValidSplit) {
      se("Total split amount must equal \$${totalAmount.currency}");
      return;
    }

    bool isConfirmed = await confirm(
      "Process split payment with ${paymentSplits.length} methods?"
    );
    
    if (!isConfirmed) return;

    showLoading();

    for (int i = 0; i < paymentSplits.length; i++) {
      final split = paymentSplits[i];
      final amount = split["amount"] as double;
      
      if (amount > 0) {
        paymentSplits[i]["status"] = "processing";
        setState(() {});
        
        // Simulate processing each payment
        await Future.delayed(Duration(seconds: 2));
        
        paymentSplits[i]["status"] = "completed";
        setState(() {});
        
        ss("${split["method_name"]} payment of \$${amount.currency} completed");
      }
    }

    hideLoading();
    ss("All split payments completed successfully");
    //navigateTo('payment_confirmation')
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Split Payment"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Split payment allows multiple payment methods for one transaction");
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
                        "Total Amount",
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
                        "Amount Assigned",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${totalAssigned.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isValidSplit ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if (remainingAmount != 0) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          remainingAmount > 0 ? "Remaining" : "Over Amount",
                          style: TextStyle(
                            fontSize: 16,
                            color: remainingAmount > 0 ? warningColor : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${remainingAmount.abs().currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: remainingAmount > 0 ? warningColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                  if (isValidSplit)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: successColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Split amounts are balanced",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Split Configuration
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
                    "Split Configuration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QDropdownField(
                    label: "Split Mode",
                    items: splitModes,
                    value: splitMode,
                    onChanged: (value, label) {
                      splitMode = value;
                      _recalculateSplits();
                    },
                  ),

                  if (splitMode == "equal") ...[
                    QNumberField(
                      label: "Number of Splits",
                      value: numberOfSplits.toString(),
                      onChanged: (value) {
                        int newCount = int.tryParse(value) ?? 2;
                        if (newCount >= 1 && newCount <= 5) {
                          numberOfSplits = newCount;
                          
                          // Adjust payment splits array
                          while (paymentSplits.length < numberOfSplits) {
                            _addPaymentSplit();
                          }
                          while (paymentSplits.length > numberOfSplits) {
                            paymentSplits.removeLast();
                          }
                          
                          _recalculateSplits();
                        }
                      },
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Each payment method: \$${(totalAmount / numberOfSplits).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Payment Methods
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
                        "Payment Methods",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (paymentSplits.length < 5)
                        QButton(
                          label: "Add Method",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _addPaymentSplit,
                        ),
                    ],
                  ),

                  ...List.generate(paymentSplits.length, (index) {
                    final split = paymentSplits[index];
                    final amount = split["amount"] as double;
                    final status = split["status"] as String;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: status == "completed" 
                          ? Border.all(color: successColor, width: 2)
                          : null,
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: (split["color"] as Color).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  split["icon"] as IconData,
                                  size: 16,
                                  color: split["color"] as Color,
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Method ${index + 1}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${split["method_name"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              if (status == "completed")
                                Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 20,
                                )
                              else if (status == "processing")
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                                  ),
                                ),
                              
                              if (paymentSplits.length > 1)
                                GestureDetector(
                                  onTap: () => _removePaymentSplit(index),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: dangerColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          Row(
                            spacing: spSm,
                            children: [
                              Expanded(
                                child: QDropdownField(
                                  label: "Payment Method",
                                  items: availablePaymentMethods.map((method) => {
                                    "label": "${method["name"]}",
                                    "value": "${method["id"]}",
                                  }).toList(),
                                  value: "${split["method"]}",
                                  onChanged: (value, label) {
                                    _updateSplitMethod(index, value);
                                  },
                                ),
                              ),
                              
                              if (splitMode != "equal")
                                Expanded(
                                  child: QNumberField(
                                    label: "Amount (\$)",
                                    value: amount > 0 ? amount.toStringAsFixed(2) : "",
                                    onChanged: (value) {
                                      double newAmount = double.tryParse(value) ?? 0.0;
                                      _updateSplitAmount(index, newAmount);
                                    },
                                  ),
                                )
                              else
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spMd,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "\$${amount.currency}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Quick Actions
            if (splitMode != "equal")
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
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Auto Balance",
                            color: infoColor,
                            size: bs.sm,
                            onPressed: () {
                              if (remainingAmount > 0 && paymentSplits.isNotEmpty) {
                                final lastIndex = paymentSplits.length - 1;
                                final currentAmount = paymentSplits[lastIndex]["amount"] as double;
                                _updateSplitAmount(lastIndex, currentAmount + remainingAmount);
                                si("Remaining amount added to last payment method");
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Clear Amounts",
                            color: disabledBoldColor,
                            size: bs.sm,
                            onPressed: () {
                              for (var split in paymentSplits) {
                                split["amount"] = 0.0;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Processing Status
            if (paymentSplits.any((split) => split["status"] == "processing"))
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
                      "Processing split payments...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Please wait while each payment is processed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
                    label: "Cancel",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: isValidSplit
                      ? "Process Split Payment"
                      : "Balance Split Amounts",
                    size: bs.md,
                    onPressed: isValidSplit ? _processSplitPayment : null,
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
