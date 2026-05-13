import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsDeliveryOptionsView extends StatefulWidget {
  const EcsDeliveryOptionsView({super.key});

  @override
  State<EcsDeliveryOptionsView> createState() => _EcsDeliveryOptionsViewState();
}

class _EcsDeliveryOptionsViewState extends State<EcsDeliveryOptionsView> {
  String selectedDeliveryType = "Standard Home Delivery";
  String selectedTimeSlot = "";
  String deliveryAddress = "123 Main St, New York, NY 10001";
  String specialInstructions = "";
  bool contactlessDelivery = false;
  bool deliveryNotifications = true;
  bool signatureRequired = false;
  String alternateContact = "";
  String alternatePhone = "";
  
  List<Map<String, dynamic>> deliveryOptions = [
    {
      "id": 1,
      "type": "Standard Home Delivery",
      "description": "Delivery to your doorstep during business hours",
      "cost": 0.0,
      "estimatedDays": "3-5",
      "icon": Icons.home,
      "color": primaryColor,
      "features": ["Free delivery", "Business hours", "Doorstep delivery"],
      "isSelected": true,
    },
    {
      "id": 2,
      "type": "Express Delivery",
      "description": "Fast delivery within 1-2 business days",
      "cost": 15.99,
      "estimatedDays": "1-2",
      "icon": Icons.speed,
      "color": dangerColor,
      "features": ["Fast delivery", "Priority handling", "Tracking included"],
      "isSelected": false,
    },
    {
      "id": 3,
      "type": "Same Day Delivery",
      "description": "Get your order delivered within 6-8 hours",
      "cost": 25.99,
      "estimatedDays": "Same day",
      "icon": Icons.flash_on,
      "color": warningColor,
      "features": ["Ultra fast", "Premium service", "Live tracking"],
      "isSelected": false,
    },
    {
      "id": 4,
      "type": "Pickup Point",
      "description": "Collect from nearby pickup location",
      "cost": 0.0,
      "estimatedDays": "2-4",
      "icon": Icons.store,
      "color": successColor,
      "features": ["Convenient pickup", "Extended hours", "Secure storage"],
      "isSelected": false,
    },
    {
      "id": 5,
      "type": "Scheduled Delivery",
      "description": "Choose your preferred delivery date and time",
      "cost": 8.99,
      "estimatedDays": "Custom",
      "icon": Icons.schedule,
      "color": infoColor,
      "features": ["Custom timing", "Flexible scheduling", "Guaranteed slot"],
      "isSelected": false,
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {
      "slot": "9:00 AM - 12:00 PM",
      "availability": "Available",
      "isAvailable": true,
    },
    {
      "slot": "12:00 PM - 3:00 PM",
      "availability": "Limited",
      "isAvailable": true,
    },
    {
      "slot": "3:00 PM - 6:00 PM",
      "availability": "Available",
      "isAvailable": true,
    },
    {
      "slot": "6:00 PM - 9:00 PM",
      "availability": "Fully Booked",
      "isAvailable": false,
    },
  ];

  List<Map<String, dynamic>> pickupLocations = [
    {
      "name": "Downtown Store",
      "address": "456 Broadway, New York, NY 10013",
      "distance": "0.8 miles",
      "hours": "Mon-Sat: 9AM-9PM, Sun: 10AM-6PM",
      "phone": "(555) 123-4567",
    },
    {
      "name": "Mall Location",
      "address": "789 Shopping Center, New York, NY 10014",
      "distance": "1.2 miles",
      "hours": "Mon-Sun: 10AM-10PM",
      "phone": "(555) 234-5678",
    },
    {
      "name": "Express Locker",
      "address": "321 Quick Mart, New York, NY 10015",
      "distance": "0.5 miles",
      "hours": "24/7 Access",
      "phone": "Self-service",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Options"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: _useCurrentLocation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryAddress(),
            SizedBox(height: spLg),
            _buildDeliveryOptions(),
            SizedBox(height: spLg),
            if (selectedDeliveryType == "Scheduled Delivery") ...[
              _buildTimeSlots(),
              SizedBox(height: spLg),
            ],
            if (selectedDeliveryType == "Pickup Point") ...[
              _buildPickupLocations(),
              SizedBox(height: spLg),
            ],
            _buildDeliveryPreferences(),
            SizedBox(height: spLg),
            _buildSpecialInstructions(),
            SizedBox(height: spLg),
            _buildAlternateContact(),
            SizedBox(height: spLg),
            _buildDeliverySummary(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Container(
          width: double.infinity,
          child: QButton(
            label: "Confirm Delivery Options",
            size: bs.md,
            onPressed: _confirmDeliveryOptions,
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Delivery Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _changeAddress,
                child: Text(
                  "Change",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.home,
                  color: disabledBoldColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    deliveryAddress,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Delivery Method",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...deliveryOptions.map((option) {
          bool isSelected = option["type"] == selectedDeliveryType;
          return GestureDetector(
            onTap: () => _selectDeliveryOption(option["type"]),
            child: Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? (option["color"] as Color).withAlpha(25) : Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isSelected ? (option["color"] as Color) : disabledOutlineBorderColor,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (option["color"] as Color).withAlpha(isSelected ? 51 : 25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          option["icon"],
                          color: option["color"],
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${option["type"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? (option["color"] as Color) : null,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${option["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            (option["cost"] as double) > 0 
                                ? "\$${(option["cost"] as double).toStringAsFixed(2)}"
                                : "FREE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (option["cost"] as double) > 0 ? primaryColor : successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${option["estimatedDays"]} days",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    children: (option["features"] as List).map((feature) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (option["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$feature",
                          style: TextStyle(
                            fontSize: 10,
                            color: option["color"],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTimeSlots() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: infoColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Select Time Slot",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...timeSlots.map((slot) {
            bool isSelected = slot["slot"] == selectedTimeSlot;
            bool isAvailable = slot["isAvailable"];
            return GestureDetector(
              onTap: isAvailable ? () => _selectTimeSlot(slot["slot"]) : null,
              child: Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryColor.withAlpha(25)
                      : isAvailable
                          ? Colors.white
                          : Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected
                        ? primaryColor
                        : isAvailable
                            ? disabledOutlineBorderColor
                            : disabledColor,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${slot["slot"]}",
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isAvailable ? null : disabledBoldColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? slot["availability"] == "Available"
                                ? successColor.withAlpha(25)
                                : warningColor.withAlpha(25)
                            : dangerColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${slot["availability"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: isAvailable
                              ? slot["availability"] == "Available"
                                  ? successColor
                                  : warningColor
                              : dangerColor,
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
    );
  }

  Widget _buildPickupLocations() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.store,
                color: successColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Pickup Locations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...pickupLocations.map((location) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${location["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${location["distance"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${location["address"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${location["hours"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${location["phone"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDeliveryPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: warningColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Delivery Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
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
                      "label": "Contactless Delivery",
                      "value": true,
                      "checked": contactlessDelivery,
                    }
                  ],
                  value: [
                    if (contactlessDelivery)
                      {
                        "label": "Contactless Delivery",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    contactlessDelivery = values.isNotEmpty;
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
                      "label": "Delivery Notifications",
                      "value": true,
                      "checked": deliveryNotifications,
                    }
                  ],
                  value: [
                    if (deliveryNotifications)
                      {
                        "label": "Delivery Notifications",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    deliveryNotifications = values.isNotEmpty;
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
                      "label": "Signature Required",
                      "value": true,
                      "checked": signatureRequired,
                    }
                  ],
                  value: [
                    if (signatureRequired)
                      {
                        "label": "Signature Required",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    signatureRequired = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
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
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                color: infoColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Special Instructions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Delivery Instructions",
            value: specialInstructions,
            hint: "e.g., Leave at front door, Ring doorbell, etc.",
            onChanged: (value) {
              specialInstructions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlternateContact() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.contact_phone,
                color: successColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Alternate Contact (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Contact Name",
            value: alternateContact,
            hint: "Backup contact person",
            onChanged: (value) {
              alternateContact = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Phone Number",
            value: alternatePhone,
            hint: "Backup phone number",
            onChanged: (value) {
              alternatePhone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverySummary() {
    var selectedOption = deliveryOptions.firstWhere(
      (option) => option["type"] == selectedDeliveryType,
    );

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt,
                color: primaryColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Delivery Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          _buildSummaryItem("Method", selectedDeliveryType),
          _buildSummaryItem("Cost", (selectedOption["cost"] as double) > 0 
              ? "\$${(selectedOption["cost"] as double).toStringAsFixed(2)}"
              : "FREE"),
          _buildSummaryItem("Estimated Delivery", "${selectedOption["estimatedDays"]} days"),
          if (selectedTimeSlot.isNotEmpty) ...[
            _buildSummaryItem("Time Slot", selectedTimeSlot),
          ],
          if (contactlessDelivery) ...[
            _buildSummaryItem("Special", "Contactless Delivery"),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectDeliveryOption(String type) {
    selectedDeliveryType = type;
    selectedTimeSlot = "";
    setState(() {});
  }

  void _selectTimeSlot(String slot) {
    selectedTimeSlot = slot;
    setState(() {});
  }

  void _useCurrentLocation() {
    si("Using current location for delivery...");
  }

  void _changeAddress() {
    si("Opening address selection...");
  }

  void _confirmDeliveryOptions() {
    if (selectedDeliveryType == "Scheduled Delivery" && selectedTimeSlot.isEmpty) {
      se("Please select a time slot for scheduled delivery");
      return;
    }

    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Delivery options confirmed successfully!");
      
      // Navigate back or to next step
      back();
    });
  }
}

