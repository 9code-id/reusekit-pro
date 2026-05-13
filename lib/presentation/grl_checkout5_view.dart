import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCheckout5View extends StatefulWidget {
  const GrlCheckout5View({Key? key}) : super(key: key);

  @override
  State<GrlCheckout5View> createState() => _GrlCheckout5ViewState();
}

class _GrlCheckout5ViewState extends State<GrlCheckout5View> {
  String selectedDeliveryOption = "express";
  String deliveryInstructions = "";
  String selectedTimeSlot = "morning";
  bool requireSignature = true;
  bool leaveAtDoor = false;
  String contactNumber = "+1 (555) 123-4567";
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Organic Vegetables Bundle",
      "image": "https://picsum.photos/80/80?random=1&keyword=vegetables",
      "price": 45.99,
      "quantity": 2,
      "perishable": true,
    },
    {
      "id": 2,
      "name": "Fresh Dairy Products",
      "image": "https://picsum.photos/80/80?random=2&keyword=dairy",
      "price": 28.50,
      "quantity": 1,
      "perishable": true,
    },
    {
      "id": 3,
      "name": "Premium Coffee Beans",
      "image": "https://picsum.photos/80/80?random=3&keyword=coffee",
      "price": 35.99,
      "quantity": 3,
      "perishable": false,
    },
  ];

  List<Map<String, dynamic>> deliveryOptions = [
    {
      "id": "standard",
      "name": "Standard Delivery",
      "description": "3-5 business days",
      "price": 5.99,
      "icon": Icons.local_shipping,
      "estimatedDays": "3-5 days",
    },
    {
      "id": "express",
      "name": "Express Delivery",
      "description": "1-2 business days",
      "price": 12.99,
      "icon": Icons.flash_on,
      "estimatedDays": "1-2 days",
    },
    {
      "id": "sameday",
      "name": "Same Day Delivery",
      "description": "Within 4-6 hours",
      "price": 24.99,
      "icon": Icons.rocket_launch,
      "estimatedDays": "Today",
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {
      "id": "morning",
      "name": "Morning",
      "time": "8:00 AM - 12:00 PM",
      "available": true,
    },
    {
      "id": "afternoon",
      "name": "Afternoon",
      "time": "12:00 PM - 5:00 PM",
      "available": true,
    },
    {
      "id": "evening",
      "name": "Evening",
      "time": "5:00 PM - 9:00 PM",
      "available": false,
    },
  ];

  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get deliveryCost => deliveryOptions.firstWhere((d) => d["id"] == selectedDeliveryOption)["price"] as double;
  double get serviceFee => 2.99;
  double get tax => (subtotal + deliveryCost + serviceFee) * 0.08;
  double get total => subtotal + deliveryCost + serviceFee + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Options"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            children: [
              _buildOrderSummary(),
              _buildDeliveryOptions(),
              _buildTimeSlotSelection(),
              _buildDeliveryPreferences(),
              _buildContactInformation(),
              _buildSpecialInstructions(),
              _buildPricingBreakdown(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildCheckoutButton(),
    );
  }

  Widget _buildOrderSummary() {
    int perishableCount = cartItems.where((item) => item["perishable"] == true).length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (perishableCount > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Perishable Items",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: cartItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${item["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (item["perishable"])
                          Positioned(
                            top: 2,
                            right: 2,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: warningColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "Qty: ${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (item["perishable"]) ...[
                                SizedBox(width: spSm),
                                Text(
                                  "• Refrigerated",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Speed",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: deliveryOptions.map((option) {
              bool isSelected = selectedDeliveryOption == option["id"];
              return GestureDetector(
                onTap: () {
                  selectedDeliveryOption = option["id"];
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(25) : Colors.grey.shade50,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          option["icon"] as IconData,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${option["name"]}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${(option["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${option["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : Colors.grey.shade500,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${option["estimatedDays"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
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
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preferred Time Slot",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: timeSlots.map((slot) {
              bool isSelected = selectedTimeSlot == slot["id"];
              bool isAvailable = slot["available"];
              
              return GestureDetector(
                onTap: isAvailable ? () {
                  selectedTimeSlot = slot["id"];
                  setState(() {});
                } : null,
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: !isAvailable 
                        ? Colors.grey.shade100
                        : isSelected 
                            ? primaryColor.withAlpha(25)
                            : Colors.grey.shade50,
                    border: Border.all(
                      color: !isAvailable 
                          ? Colors.grey.shade300
                          : isSelected 
                              ? primaryColor 
                              : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: !isAvailable 
                            ? Colors.grey.shade400
                            : isSelected 
                                ? primaryColor 
                                : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${slot["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: !isAvailable ? Colors.grey.shade400 : Colors.black,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${slot["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: !isAvailable ? Colors.grey.shade400 : disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (!isAvailable) ...[
                        SizedBox(height: spXs),
                        Text(
                          "Not Available",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Require signature",
                      "value": true,
                      "checked": requireSignature,
                    }
                  ],
                  value: [
                    if (requireSignature)
                      {
                        "label": "Require signature",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    requireSignature = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Leave at door if no one's home",
                      "value": true,
                      "checked": leaveAtDoor,
                    }
                  ],
                  value: [
                    if (leaveAtDoor)
                      {
                        "label": "Leave at door if no one's home",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    leaveAtDoor = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (leaveAtDoor) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Package will be left unattended. We're not responsible for theft or damage.",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Phone Number",
            value: contactNumber,
            hint: "+1 (555) 123-4567",
            validator: Validator.required,
            onChanged: (value) {
              contactNumber = value;
              setState(() {});
            },
          ),
          SizedBox(height: spXs),
          Text(
            "We'll call or text you with delivery updates",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialInstructions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Instructions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Special instructions (optional)",
            value: deliveryInstructions,
            hint: "e.g., Ring doorbell twice, Leave at back door, Call when arrived...",
            onChanged: (value) {
              deliveryInstructions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Total",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          _buildPriceRow("Subtotal", subtotal),
          _buildPriceRow("Delivery", deliveryCost),
          _buildPriceRow("Service Fee", serviceFee),
          _buildPriceRow("Tax", tax),
          Divider(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    String deliveryTime = deliveryOptions.firstWhere((d) => d["id"] == selectedDeliveryOption)["estimatedDays"];
    String timeSlot = timeSlots.firstWhere((t) => t["id"] == selectedTimeSlot)["name"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowLg],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: primaryColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Delivery: $deliveryTime ($timeSlot)",
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "\$${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Confirm Order & Pay",
              size: bs.md,
              onPressed: _confirmOrder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmOrder() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      Future.delayed(Duration(seconds: 3), () {
        hideLoading();
        ss("Order confirmed! You'll receive delivery updates via SMS.");
        // Navigate to order confirmation
      });
    }
  }
}
