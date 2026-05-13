import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCheckoutView extends StatefulWidget {
  const FdaCheckoutView({super.key});

  @override
  State<FdaCheckoutView> createState() => _FdaCheckoutViewState();
}

class _FdaCheckoutViewState extends State<FdaCheckoutView> {
  int selectedAddressIndex = 0;
  int selectedPaymentIndex = 0;
  int selectedDeliveryOption = 0;
  String deliveryInstructions = "";
  bool saveInstructions = false;
  bool contactlessDelivery = true;
  String selectedTip = "15";

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Margherita Pizza",
      "restaurant": "Tony's Italian Kitchen",
      "quantity": 2,
      "price": 24.99,
      "size": "Medium",
      "addons": ["Extra Cheese"],
    },
    {
      "name": "Caesar Salad",
      "restaurant": "Green Garden Cafe",
      "quantity": 1,
      "price": 12.99,
      "size": "Regular",
      "addons": ["Grilled Chicken"],
    },
  ];

  List<Map<String, dynamic>> addresses = [
    {
      "id": "1",
      "type": "Home",
      "name": "John Doe",
      "address": "123 Main Street, Apt 4B",
      "city": "New York, NY 10001",
      "phone": "+1 (555) 123-4567",
      "isDefault": true,
    },
    {
      "id": "2",
      "type": "Work",
      "name": "John Doe",
      "address": "456 Business Ave, Suite 200",
      "city": "New York, NY 10002",
      "phone": "+1 (555) 987-6543",
      "isDefault": false,
    },
    {
      "id": "3",
      "type": "Other",
      "name": "Jane Smith",
      "address": "789 Park Lane, Building C",
      "city": "New York, NY 10003",
      "phone": "+1 (555) 456-7890",
      "isDefault": false,
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "1",
      "type": "Credit Card",
      "name": "Visa ending in 4567",
      "icon": Icons.credit_card,
      "isDefault": true,
    },
    {
      "id": "2",
      "type": "Digital Wallet",
      "name": "PayPal",
      "icon": Icons.account_balance_wallet,
      "isDefault": false,
    },
    {
      "id": "3",
      "type": "Cash",
      "name": "Cash on Delivery",
      "icon": Icons.payments,
      "isDefault": false,
    },
  ];

  List<Map<String, dynamic>> deliveryOptions = [
    {
      "type": "Standard",
      "time": "45-60 min",
      "fee": 3.99,
      "description": "Regular delivery",
    },
    {
      "type": "Express",
      "time": "25-35 min",
      "fee": 6.99,
      "description": "Priority delivery",
    },
    {
      "type": "Scheduled",
      "time": "Choose time",
      "fee": 2.99,
      "description": "Deliver at your preferred time",
    },
  ];

  List<Map<String, dynamic>> tipOptions = [
    {"label": "10%", "value": "10"},
    {"label": "15%", "value": "15"},
    {"label": "20%", "value": "20"},
    {"label": "25%", "value": "25"},
    {"label": "Custom", "value": "custom"},
  ];

  double get subtotal {
    return orderItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get deliveryFee {
    return deliveryOptions[selectedDeliveryOption]["fee"] as double;
  }

  double get serviceFee => 2.50;
  double get taxes => subtotal * 0.08;
  
  double get tipAmount {
    if (selectedTip == "custom") return 5.0; // Default custom amount
    double tipPercentage = double.parse(selectedTip) / 100;
    return subtotal * tipPercentage;
  }

  double get total => subtotal + deliveryFee + serviceFee + taxes + tipAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              // Show help
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Expanded(
                        child: Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          back();
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...orderItems.map((item) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: disabledOutlineBorderColor.withAlpha(100)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "${item["quantity"]}x",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${item["restaurant"]} • ${item["size"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ((item["addons"] as List).isNotEmpty)
                                  Text(
                                    "Add-ons: ${(item["addons"] as List).join(", ")}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(((item["price"] as double) * (item["quantity"] as int))).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Delivery Address
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Expanded(
                        child: Text(
                          "Delivery Address",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to address management
                        },
                        child: Text(
                          "Change",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...addresses.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> address = entry.value;
                    bool isSelected = selectedAddressIndex == index;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAddressIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(top: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.transparent,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: isSelected
                                  ? Icon(Icons.check, color: Colors.white, size: 14)
                                  : null,
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              address["type"] == "Home" ? Icons.home :
                              address["type"] == "Work" ? Icons.work : Icons.location_on,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${address["type"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? primaryColor : Colors.black,
                                        ),
                                      ),
                                      if (address["isDefault"] as bool) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Default",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${address["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${address["address"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${address["city"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${address["phone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  QButton(
                    label: "Add New Address",
                    size: bs.sm,
                    icon: Icons.add_location,
                    onPressed: () {
                      // Navigate to add address
                    },
                  ),
                ],
              ),
            ),

            // Delivery Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Delivery Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...deliveryOptions.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> option = entry.value;
                    bool isSelected = selectedDeliveryOption == index;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDeliveryOption = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(top: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.transparent,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: isSelected
                                  ? Icon(Icons.check, color: Colors.white, size: 14)
                                  : null,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${option["type"]} • ${option["time"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? primaryColor : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${option["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${((option["fee"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Payment Method
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Expanded(
                        child: Text(
                          "Payment Method",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to payment methods
                        },
                        child: Text(
                          "Manage",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...paymentMethods.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> method = entry.value;
                    bool isSelected = selectedPaymentIndex == index;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPaymentIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(top: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.transparent,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: isSelected
                                  ? Icon(Icons.check, color: Colors.white, size: 14)
                                  : null,
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              method["icon"] as IconData,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${method["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? primaryColor : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${method["type"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (method["isDefault"] as bool)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Default",
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
                ],
              ),
            ),

            // Tip Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Tip Your Delivery Partner",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "100% of your tip goes to the delivery partner",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  QHorizontalScroll(
                    children: tipOptions.map((tip) {
                      bool isSelected = selectedTip == tip["value"];
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTip = tip["value"];
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Text(
                            "${tip["label"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (selectedTip == "custom")
                    QNumberField(
                      label: "Custom Tip Amount",
                      value: "5.00",
                      onChanged: (value) {
                        // Update custom tip
                      },
                    ),
                  Text(
                    "Tip amount: \$${tipAmount.currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Delivery Instructions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Delivery Instructions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QMemoField(
                    label: "Add delivery instructions",
                    value: deliveryInstructions,
                    hint: "e.g., Ring the doorbell, Call when arrived, etc.",
                    onChanged: (value) {
                      deliveryInstructions = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Icon(Icons.health_and_safety, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Contactless Delivery",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Switch(
                        value: contactlessDelivery,
                        onChanged: (value) {
                          setState(() {
                            contactlessDelivery = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bill Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Bill Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildBillRow("Subtotal", subtotal),
                  _buildBillRow("Delivery Fee", deliveryFee),
                  _buildBillRow("Service Fee", serviceFee),
                  _buildBillRow("Taxes & Fees", taxes),
                  _buildBillRow("Tip", tipAmount),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "\$${total.currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: QButton(
          label: "Place Order • \$${total.currency}",
          size: bs.md,
          icon: Icons.check_circle,
          onPressed: () {
            // Process order
            showLoading();
            Future.delayed(Duration(seconds: 2), () {
              hideLoading();
              ss("Order placed successfully!");
              // Navigate to order confirmation
            });
          },
        ),
      ),
    );
  }

  Widget _buildBillRow(String label, double amount) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
