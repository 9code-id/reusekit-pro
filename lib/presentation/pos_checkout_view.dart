import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCheckoutView extends StatefulWidget {
  const PosCheckoutView({super.key});

  @override
  State<PosCheckoutView> createState() => _PosCheckoutViewState();
}

class _PosCheckoutViewState extends State<PosCheckoutView> {
  String paymentMethod = "cash";
  String customerEmail = "";
  String customerPhone = "";
  double amountReceived = 0.0;
  String discountCode = "";
  double discountAmount = 0.0;
  String discountType = "percentage";
  bool printReceipt = true;
  bool emailReceipt = false;
  String notes = "";
  bool splitPayment = false;
  double cashAmount = 0.0;
  double cardAmount = 0.0;

  final List<Map<String, dynamic>> paymentMethods = [
    {"label": "Cash", "value": "cash", "icon": Icons.money},
    {"label": "Credit Card", "value": "card", "icon": Icons.credit_card},
    {"label": "Debit Card", "value": "debit", "icon": Icons.credit_card},
    {"label": "Mobile Payment", "value": "mobile", "icon": Icons.phone_android},
    {"label": "Gift Card", "value": "gift", "icon": Icons.card_giftcard},
    {"label": "Split Payment", "value": "split", "icon": Icons.call_split},
  ];

  final List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Premium Coffee Beans",
      "price": 24.99,
      "quantity": 2,
      "discount": 0.0,
    },
    {
      "id": 2,
      "name": "Wireless Headphones",
      "price": 89.99,
      "quantity": 1,
      "discount": 5.0,
    },
    {
      "id": 3,
      "name": "Cotton T-Shirt",
      "price": 19.99,
      "quantity": 3,
      "discount": 0.0,
    },
    {
      "id": 4,
      "name": "Hand Sanitizer",
      "price": 5.99,
      "quantity": 2,
      "discount": 0.0,
    },
  ];

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) {
      double itemTotal = (item["price"] as double) * (item["quantity"] as int);
      return sum + itemTotal - (item["discount"] as double);
    });
  }

  double get taxAmount {
    return subtotal * 0.085; // 8.5% tax
  }

  double get totalAmount {
    return subtotal + taxAmount - discountAmount;
  }

  double get changeAmount {
    if (paymentMethod == "cash" && amountReceived > totalAmount) {
      return amountReceived - totalAmount;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        actions: [
          QButton(
            label: "Hold Order",
            size: bs.sm,
            onPressed: _holdOrder,
          ),
        ],
      ),
      body: Row(
        children: [
          // Left Panel - Order Summary
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Items
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
                          "Order Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          height: 300,
                          child: SingleChildScrollView(
                            child: Column(
                              children: cartItems.map((item) => _buildOrderItem(item)).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Discount Section
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
                          "Apply Discount",
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
                              child: QTextField(
                                label: "Discount Code",
                                value: discountCode,
                                hint: "Enter promo code",
                                onChanged: (value) {
                                  discountCode = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            QButton(
                              label: "Apply",
                              size: bs.sm,
                              onPressed: _applyDiscount,
                            ),
                          ],
                        ),
                        if (discountAmount > 0) ...[
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.green[200]!),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green[600],
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Discount Applied: -\$${discountAmount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: _removeDiscount,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.green[600],
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Customer Information
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
                          "Customer Information (Optional)",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QTextField(
                          label: "Email Address",
                          value: customerEmail,
                          hint: "customer@email.com",
                          onChanged: (value) {
                            customerEmail = value;
                            setState(() {});
                          },
                        ),
                        QTextField(
                          label: "Phone Number",
                          value: customerPhone,
                          hint: "+1 (555) 123-4567",
                          onChanged: (value) {
                            customerPhone = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Panel - Payment
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Payment Header
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.payment,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Payment",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Payment Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spMd,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Payment Total
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Text("Subtotal:"),
                                  Spacer(),
                                  Text("\$${subtotal.toStringAsFixed(2)}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Tax (8.5%):"),
                                  Spacer(),
                                  Text("\$${taxAmount.toStringAsFixed(2)}"),
                                ],
                              ),
                              if (discountAmount > 0)
                                Row(
                                  children: [
                                    Text(
                                      "Discount:",
                                      style: TextStyle(color: Colors.green[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "-\$${discountAmount.toStringAsFixed(2)}",
                                      style: TextStyle(color: Colors.green[600]),
                                    ),
                                  ],
                                ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${totalAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Payment Method Selection
                        Text(
                          "Payment Method",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Wrap(
                          spacing: spSm,
                          runSpacing: spSm,
                          children: paymentMethods.map((method) {
                            bool isSelected = paymentMethod == method["value"];
                            return GestureDetector(
                              onTap: () {
                                paymentMethod = method["value"];
                                if (paymentMethod == "split") {
                                  splitPayment = true;
                                  cashAmount = totalAmount / 2;
                                  cardAmount = totalAmount / 2;
                                } else {
                                  splitPayment = false;
                                  cashAmount = 0.0;
                                  cardAmount = 0.0;
                                }
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor.withAlpha(25) : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      method["icon"],
                                      color: isSelected ? primaryColor : disabledBoldColor,
                                      size: 24,
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${method["label"]}",
                                      style: TextStyle(
                                        color: isSelected ? primaryColor : disabledBoldColor,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Payment Amount Input
                        if (paymentMethod == "cash") ...[
                          QNumberField(
                            label: "Amount Received",
                            value: amountReceived.toString(),
                            onChanged: (value) {
                              amountReceived = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                          if (changeAmount > 0)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: Colors.green[200]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_return,
                                    color: Colors.green[600],
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Change: \$${changeAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],

                        // Split Payment
                        if (splitPayment) ...[
                          Text(
                            "Split Payment",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          QNumberField(
                            label: "Cash Amount",
                            value: cashAmount.toString(),
                            onChanged: (value) {
                              cashAmount = double.tryParse(value) ?? 0.0;
                              cardAmount = totalAmount - cashAmount;
                              setState(() {});
                            },
                          ),
                          QNumberField(
                            label: "Card Amount",
                            value: cardAmount.toString(),
                            onChanged: (value) {
                              cardAmount = double.tryParse(value) ?? 0.0;
                              cashAmount = totalAmount - cardAmount;
                              setState(() {});
                            },
                          ),
                        ],

                        // Receipt Options
                        Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Receipt Options",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            QSwitch(
                              items: [
                                {
                                  "label": "Print Receipt",
                                  "value": true,
                                  "checked": printReceipt,
                                }
                              ],
                              value: printReceipt ? [{"label": "Print Receipt", "value": true, "checked": true}] : [],
                              onChanged: (values, ids) {
                                printReceipt = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                            QSwitch(
                              items: [
                                {
                                  "label": "Email Receipt",
                                  "value": true,
                                  "checked": emailReceipt,
                                }
                              ],
                              value: emailReceipt ? [{"label": "Email Receipt", "value": true, "checked": true}] : [],
                              onChanged: (values, ids) {
                                emailReceipt = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                          ],
                        ),

                        // Notes
                        QMemoField(
                          label: "Transaction Notes",
                          value: notes,
                          hint: "Add any special notes for this transaction",
                          onChanged: (value) {
                            notes = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Payment Actions
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Complete Payment - \$${totalAmount.toStringAsFixed(2)}",
                          size: bs.md,
                          onPressed: _completePayment,
                        ),
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Cancel",
                              size: bs.sm,
                              onPressed: () => back(),
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Save & Hold",
                              size: bs.sm,
                              onPressed: _holdOrder,
                            ),
                          ),
                        ],
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

  Widget _buildOrderItem(Map<String, dynamic> item) {
    double itemTotal = (item["price"] as double) * (item["quantity"] as int);
    double itemDiscount = item["discount"] as double;
    double finalTotal = itemTotal - itemDiscount;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${item["quantity"]} × \$${(item["price"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (itemDiscount > 0)
                  Text(
                    "Discount: -\$${itemDiscount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green[600],
                    ),
                  ),
              ],
            ),
          ),
          Text(
            "\$${finalTotal.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _applyDiscount() {
    if (discountCode.isNotEmpty) {
      // Simulate discount validation
      if (discountCode.toLowerCase() == "save10") {
        discountAmount = subtotal * 0.10;
        discountType = "percentage";
        ss("10% discount applied!");
      } else if (discountCode.toLowerCase() == "welcome5") {
        discountAmount = 5.0;
        discountType = "fixed";
        ss("\$5 discount applied!");
      } else {
        se("Invalid discount code");
        return;
      }
      setState(() {});
    }
  }

  void _removeDiscount() {
    discountCode = "";
    discountAmount = 0.0;
    setState(() {});
    ss("Discount removed");
  }

  void _completePayment() async {
    // Validate payment
    if (paymentMethod == "cash" && amountReceived < totalAmount) {
      se("Insufficient amount received");
      return;
    }

    if (splitPayment && (cashAmount + cardAmount) != totalAmount) {
      se("Split payment amounts don't match total");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();

    ss("Payment completed successfully!");
    
    // Navigate back or to receipt view
    back();
  }

  void _holdOrder() async {
    bool isConfirmed = await confirm("Hold this order for later?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Order held successfully");
      back();
    }
  }
}
