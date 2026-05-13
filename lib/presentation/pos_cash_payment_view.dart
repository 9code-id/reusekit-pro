import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCashPaymentView extends StatefulWidget {
  const PosCashPaymentView({super.key});

  @override
  State<PosCashPaymentView> createState() => _PosCashPaymentViewState();
}

class _PosCashPaymentViewState extends State<PosCashPaymentView> {
  String amountReceived = "";
  double totalAmount = 126.85;
  bool exactChange = false;
  
  final List<double> quickAmounts = [
    20.0, 50.0, 100.0, 150.0, 200.0, 500.0
  ];

  final List<Map<String, dynamic>> denominations = [
    {"value": 100.0, "type": "bill", "count": 0},
    {"value": 50.0, "type": "bill", "count": 0},
    {"value": 20.0, "type": "bill", "count": 0},
    {"value": 10.0, "type": "bill", "count": 0},
    {"value": 5.0, "type": "bill", "count": 0},
    {"value": 1.0, "type": "bill", "count": 0},
    {"value": 0.25, "type": "coin", "count": 0},
    {"value": 0.10, "type": "coin", "count": 0},
    {"value": 0.05, "type": "coin", "count": 0},
    {"value": 0.01, "type": "coin", "count": 0},
  ];

  double get receivedAmount {
    if (exactChange) return totalAmount;
    if (amountReceived.isEmpty) return 0.0;
    return double.tryParse(amountReceived) ?? 0.0;
  }

  double get changeAmount {
    return receivedAmount - totalAmount;
  }

  bool get isValidPayment {
    return receivedAmount >= totalAmount;
  }

  void _setQuickAmount(double amount) {
    exactChange = false;
    amountReceived = amount.toStringAsFixed(2);
    setState(() {});
  }

  void _setExactChange() {
    exactChange = true;
    amountReceived = totalAmount.toStringAsFixed(2);
    setState(() {});
  }

  void _updateDenomination(int index, bool increment) {
    if (increment) {
      denominations[index]["count"]++;
    } else {
      if ((denominations[index]["count"] as int) > 0) {
        denominations[index]["count"]--;
      }
    }
    
    // Calculate total from denominations
    double total = 0.0;
    for (var denom in denominations) {
      total += (denom["value"] as double) * (denom["count"] as int);
    }
    
    exactChange = false;
    amountReceived = total.toStringAsFixed(2);
    setState(() {});
  }

  void _clearDenominations() {
    for (var denom in denominations) {
      denom["count"] = 0;
    }
    amountReceived = "";
    exactChange = false;
    setState(() {});
  }

  Map<String, int> _calculateChange() {
    if (changeAmount <= 0) return {};
    
    Map<String, int> change = {};
    double remaining = changeAmount;
    
    for (var denom in denominations) {
      double value = denom["value"] as double;
      if (remaining >= value) {
        int count = (remaining / value).floor();
        if (count > 0) {
          change[_getDenominationName(value)] = count;
          remaining -= count * value;
          remaining = double.parse(remaining.toStringAsFixed(2));
        }
      }
    }
    
    return change;
  }

  String _getDenominationName(double value) {
    if (value >= 1) {
      return "\$${value.toInt()}";
    } else {
      int cents = (value * 100).round();
      return "${cents}¢";
    }
  }

  void _processPayment() async {
    if (!isValidPayment) {
      se("Insufficient payment amount");
      return;
    }

    bool isConfirmed = await confirm(
      "Process cash payment of \$${receivedAmount.currency}?"
    );
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate processing
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Cash payment processed successfully");
      
      if (changeAmount > 0) {
        si("Change due: \$${changeAmount.currency}");
      }
      
      //navigateTo('payment_confirmation')
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cash Payment"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Enter the cash amount received from customer");
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
                        "Amount Received",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${receivedAmount.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isValidPayment ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if (changeAmount != 0) ...[
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          changeAmount > 0 ? "Change Due" : "Amount Short",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: changeAmount > 0 ? successColor : dangerColor,
                          ),
                        ),
                        Text(
                          "\$${changeAmount.abs().currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: changeAmount > 0 ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Amount Input
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
                    "Enter Amount Received",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QNumberField(
                    label: "Cash Amount (\$)",
                    value: exactChange ? totalAmount.toStringAsFixed(2) : amountReceived,
                    onChanged: (value) {
                      exactChange = false;
                      amountReceived = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Exact Change",
                              "value": true,
                              "checked": exactChange,
                            }
                          ],
                          value: [
                            if (exactChange)
                              {
                                "label": "Exact Change",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            if (values.isNotEmpty) {
                              _setExactChange();
                            } else {
                              exactChange = false;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  // Quick Amount Buttons
                  Text(
                    "Quick Amounts",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 80,
                    children: quickAmounts.map((amount) {
                      return GestureDetector(
                        onTap: () => _setQuickAmount(amount),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: primaryColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            "\$${amount.toInt()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Denomination Counter
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
                        "Count by Denomination",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Clear",
                        color: disabledBoldColor,
                        size: bs.sm,
                        onPressed: _clearDenominations,
                      ),
                    ],
                  ),

                  ...List.generate(denominations.length, (index) {
                    final denom = denominations[index];
                    final value = denom["value"] as double;
                    final count = denom["count"] as int;
                    final isBill = denom["type"] == "bill";
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isBill ? successColor : warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Center(
                              child: Text(
                                _getDenominationName(value),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: Text(
                              isBill ? "Bill" : "Coin",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => _updateDenomination(index, false),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: dangerColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: dangerColor,
                                  ),
                                ),
                              ),
                              
                              Container(
                                width: 40,
                                child: Text(
                                  "$count",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              
                              GestureDetector(
                                onTap: () => _updateDenomination(index, true),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: successColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(width: spSm),
                          Text(
                            "\$${(value * count).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Change Breakdown
            if (changeAmount > 0)
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
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.change_circle,
                          size: 20,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Change Breakdown",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    ..._calculateChange().entries.map((entry) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${entry.value}x ${entry.key}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(double.parse(entry.key.replaceAll(RegExp(r'[^\d.]'), '')) * entry.value / (entry.key.contains('¢') ? 100 : 1)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      );
                    }),
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
                    label: isValidPayment 
                      ? "Process Payment"
                      : "Insufficient Amount",
                    size: bs.md,
                    onPressed: isValidPayment ? _processPayment : null,
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
