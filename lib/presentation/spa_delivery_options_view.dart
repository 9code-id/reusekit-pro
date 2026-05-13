import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaDeliveryOptionsView extends StatefulWidget {
  const SpaDeliveryOptionsView({super.key});

  @override
  State<SpaDeliveryOptionsView> createState() => _SpaDeliveryOptionsViewState();
}

class _SpaDeliveryOptionsViewState extends State<SpaDeliveryOptionsView> {
  String selectedOption = "";
  String deliveryAddress = "";
  String phoneNumber = "";
  String specialInstructions = "";
  String selectedTimeSlot = "";
  String deliveryDate = DateTime.now().add(Duration(days: 1)).toIso8601String();
  bool requiresSignature = false;
  bool contactlessDelivery = false;
  double totalOrderValue = 250.00;
  
  List<Map<String, dynamic>> deliveryOptions = [
    {
      "id": "standard",
      "name": "Standard Delivery",
      "description": "Regular delivery within 3-5 business days",
      "price": 9.99,
      "estimatedTime": "3-5 business days",
      "icon": Icons.local_shipping,
      "features": [
        "Free delivery on orders over \$100",
        "Package tracking included",
        "Delivered during business hours",
        "Signature required for delivery"
      ],
      "minOrderValue": 0.0,
      "maxWeight": 50.0,
      "availability": "Available nationwide",
      "color": primaryColor,
    },
    {
      "id": "express",
      "name": "Express Delivery",
      "description": "Fast delivery within 1-2 business days",
      "price": 19.99,
      "estimatedTime": "1-2 business days",
      "icon": Icons.flash_on,
      "features": [
        "Priority handling and delivery",
        "Real-time tracking updates",
        "Flexible delivery time slots",
        "SMS notifications included"
      ],
      "minOrderValue": 50.0,
      "maxWeight": 30.0,
      "availability": "Major cities only",
      "color": warningColor,
    },
    {
      "id": "same_day",
      "name": "Same Day Delivery",
      "description": "Delivered the same day if ordered before 2 PM",
      "price": 29.99,
      "estimatedTime": "4-8 hours",
      "icon": Icons.rocket_launch,
      "features": [
        "Ultra-fast same-day delivery",
        "Live delivery tracking",
        "Direct contact with driver",
        "Premium packaging included"
      ],
      "minOrderValue": 100.0,
      "maxWeight": 20.0,
      "availability": "Limited metro areas",
      "color": dangerColor,
    },
    {
      "id": "pickup",
      "name": "Store Pickup",
      "description": "Pick up your order from our nearest location",
      "price": 0.0,
      "estimatedTime": "Ready in 2-4 hours",
      "icon": Icons.store,
      "features": [
        "No delivery charges",
        "Pick up at your convenience",
        "Order verification required",
        "Extended pickup hours available"
      ],
      "minOrderValue": 0.0,
      "maxWeight": 100.0,
      "availability": "All store locations",
      "color": successColor,
    },
    {
      "id": "scheduled",
      "name": "Scheduled Delivery",
      "description": "Choose your preferred delivery date and time",
      "price": 14.99,
      "estimatedTime": "On your selected date",
      "icon": Icons.schedule,
      "features": [
        "Choose specific delivery date",
        "2-hour delivery window",
        "Advance booking up to 30 days",
        "Rescheduling options available"
      ],
      "minOrderValue": 75.0,
      "maxWeight": 40.0,
      "availability": "Selected regions",
      "color": infoColor,
    },
    {
      "id": "premium",
      "name": "Premium White Glove",
      "description": "Premium delivery with unpacking and setup service",
      "price": 49.99,
      "estimatedTime": "2-3 business days",
      "icon": Icons.star,
      "features": [
        "Professional delivery team",
        "Unpacking and setup service",
        "Packaging removal included",
        "Product demonstration available"
      ],
      "minOrderValue": 200.0,
      "maxWeight": 75.0,
      "availability": "Premium service areas",
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"label": "9:00 AM - 11:00 AM", "value": "morning_early"},
    {"label": "11:00 AM - 1:00 PM", "value": "morning_late"},
    {"label": "1:00 PM - 3:00 PM", "value": "afternoon_early"},
    {"label": "3:00 PM - 5:00 PM", "value": "afternoon_late"},
    {"label": "5:00 PM - 7:00 PM", "value": "evening"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> availableOptions = _getAvailableOptions();
    Map<String, dynamic>? selectedOptionData = selectedOption.isNotEmpty 
        ? deliveryOptions.firstWhere((opt) => opt["id"] == selectedOption)
        : null;
    
    double deliveryFee = selectedOptionData != null ? (selectedOptionData["price"] as double) : 0.0;
    double finalTotal = totalOrderValue + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Options"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "\$${totalOrderValue.currency}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Order Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Total",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "\$${totalOrderValue.currency}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "3 spa products • 2.5 kg total weight",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Delivery Options
            Text(
              "Choose Delivery Method",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Select the delivery option that best suits your needs",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),

            ...availableOptions.map((option) => _buildDeliveryOptionCard(option)).toList(),

            // Delivery Details Form
            if (selectedOption.isNotEmpty && selectedOption != "pickup") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Delivery Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    QTextField(
                      label: "Delivery Address",
                      value: deliveryAddress,
                      hint: "Enter your complete delivery address",
                      validator: Validator.required,
                      onChanged: (value) {
                        deliveryAddress = value;
                        setState(() {});
                      },
                    ),

                    QTextField(
                      label: "Contact Phone Number",
                      value: phoneNumber,
                      hint: "Enter your phone number for delivery updates",
                      validator: Validator.required,
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),

                    if (selectedOption == "scheduled") ...[
                      QDatePicker(
                        label: "Preferred Delivery Date",
                        value: DateTime.parse(deliveryDate),
                        onChanged: (value) {
                          deliveryDate = value.toIso8601String();
                          setState(() {});
                        },
                      ),

                      QDropdownField(
                        label: "Time Slot",
                        items: timeSlots,
                        value: selectedTimeSlot,
                        onChanged: (value, label) {
                          selectedTimeSlot = value;
                          setState(() {});
                        },
                      ),
                    ],

                    QMemoField(
                      label: "Special Instructions",
                      value: specialInstructions,
                      hint: "Any special delivery instructions (optional)",
                      onChanged: (value) {
                        specialInstructions = value;
                        setState(() {});
                      },
                    ),

                    // Delivery Preferences
                    Text(
                      "Delivery Preferences",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    QSwitch(
                      items: [
                        {
                          "label": "Require signature for delivery",
                          "value": true,
                          "checked": requiresSignature,
                        }
                      ],
                      value: [if (requiresSignature) {"label": "Require signature for delivery", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        requiresSignature = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    QSwitch(
                      items: [
                        {
                          "label": "Contactless delivery (leave at door)",
                          "value": true,
                          "checked": contactlessDelivery,
                        }
                      ],
                      value: [if (contactlessDelivery) {"label": "Contactless delivery (leave at door)", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        contactlessDelivery = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Pickup Details
            if (selectedOption == "pickup") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.store,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Store Pickup Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Serenity Spa Downtown",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "123 Main Street, Downtown",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Pickup Hours: 9:00 AM - 8:00 PM",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "• Your order will be ready for pickup within 2-4 hours\n• Please bring a valid ID for order verification\n• Call ahead if you need assistance with large items\n• Free storage for up to 7 days",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Order Summary
            if (selectedOption.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "\$${totalOrderValue.currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "${selectedOptionData!["name"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          deliveryFee == 0 ? "FREE" : "\$${deliveryFee.currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: deliveryFee == 0 ? successColor : primaryColor,
                          ),
                        ),
                      ],
                    ),

                    if (totalOrderValue >= 100 && selectedOption == "standard")
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Free delivery on orders over \$100!",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    Divider(),

                    Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${finalTotal.currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Estimated delivery: ${selectedOptionData["estimatedTime"]}",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: selectedOption.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: QButton(
                label: "Confirm Delivery Option",
                size: bs.md,
                onPressed: _confirmDeliveryOption,
              ),
            )
          : null,
    );
  }

  Widget _buildDeliveryOptionCard(Map<String, dynamic> option) {
    bool isSelected = selectedOption == option["id"];
    bool isEligible = totalOrderValue >= (option["minOrderValue"] as double);
    Color optionColor = option["color"];

    return GestureDetector(
      onTap: isEligible ? () {
        selectedOption = option["id"];
        setState(() {});
      } : null,
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? optionColor.withAlpha(50) : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowMd],
          border: Border.all(
            color: isSelected ? optionColor : 
                   isEligible ? disabledOutlineBorderColor : 
                   disabledColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isEligible ? optionColor.withAlpha(30) : disabledColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    option["icon"],
                    color: isEligible ? optionColor : disabledBoldColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${option["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: isEligible ? (isSelected ? optionColor : primaryColor) : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${option["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      (option["price"] as double) == 0 ? "FREE" : "\$${(option["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: (option["price"] as double) == 0 ? successColor : optionColor,
                      ),
                    ),
                    Text(
                      "${option["estimatedTime"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                if (isSelected)
                  Container(
                    margin: EdgeInsets.only(left: spSm),
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: optionColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),

            // Features
            ...((option["features"] as List).take(3)).map((feature) {
              return Row(
                children: [
                  Icon(
                    Icons.check,
                    color: isEligible ? optionColor : disabledBoldColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "$feature",
                      style: TextStyle(
                        color: isEligible ? primaryColor : disabledBoldColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),

            // Eligibility Info
            if (!isEligible)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: dangerColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Minimum order value: \$${(option["minOrderValue"] as double).currency}",
                        style: TextStyle(
                          color: dangerColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Additional Info
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: disabledBoldColor,
                  size: 14,
                ),
                SizedBox(width: spXs),
                Text(
                  "${option["availability"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.fitness_center,
                  color: disabledBoldColor,
                  size: 14,
                ),
                SizedBox(width: spXs),
                Text(
                  "Max ${(option["maxWeight"] as double).toStringAsFixed(0)} kg",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getAvailableOptions() {
    return deliveryOptions;
  }

  void _confirmDeliveryOption() async {
    Map<String, dynamic>? selectedOptionData = deliveryOptions
        .firstWhere((opt) => opt["id"] == selectedOption);
    
    bool isConfirmed = await confirm("Confirm delivery option: ${selectedOptionData["name"]}?");
    if (isConfirmed) {
      ss("Delivery option confirmed: ${selectedOptionData["name"]}");
      back();
    }
  }
}
