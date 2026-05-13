import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAddress9View extends StatefulWidget {
  @override
  State<GrlAddress9View> createState() => _GrlAddress9ViewState();
}

class _GrlAddress9ViewState extends State<GrlAddress9View> {
  String selectedAddress = "";
  String deliveryInstructions = "";
  String contactMethod = "phone";
  bool saveInstructions = true;
  bool notifyOnDelivery = true;
  String doorAccessCode = "";
  String buildingFloor = "";
  String specificLocation = "";

  List<Map<String, dynamic>> addresses = [
    {
      "id": 1,
      "title": "Home Sweet Home",
      "name": "John Doe",
      "phone": "+1 (555) 123-4567",
      "address": "123 Main Street, Apt 4B",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "type": "home",
      "isDefault": true,
    },
    {
      "id": 2,
      "title": "Office Building",
      "name": "John Doe",
      "phone": "+1 (555) 987-6543",
      "address": "456 Business Avenue, Suite 200",
      "city": "New York",
      "state": "NY",
      "zipCode": "10002",
      "type": "work",
      "isDefault": false,
    },
  ];

  List<Map<String, dynamic>> contactMethodItems = [
    {"label": "Phone Call", "value": "phone"},
    {"label": "Text Message", "value": "sms"},
    {"label": "Push Notification", "value": "push"},
    {"label": "Email", "value": "email"},
  ];

  List<Map<String, dynamic>> deliveryTimeSlots = [
    {
      "id": 1,
      "time": "9:00 AM - 12:00 PM",
      "label": "Morning",
      "available": true,
      "fee": 0,
    },
    {
      "id": 2,
      "time": "12:00 PM - 3:00 PM",
      "label": "Afternoon",
      "available": true,
      "fee": 0,
    },
    {
      "id": 3,
      "time": "3:00 PM - 6:00 PM",
      "label": "Evening",
      "available": true,
      "fee": 2.99,
    },
    {
      "id": 4,
      "time": "6:00 PM - 9:00 PM",
      "label": "Night",
      "available": false,
      "fee": 4.99,
    },
  ];

  String selectedTimeSlot = "1";

  @override
  void initState() {
    super.initState();
    // Set default address
    if (addresses.any((addr) => addr["isDefault"] as bool)) {
      selectedAddress = addresses.firstWhere((addr) => addr["isDefault"] as bool)["id"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedAddressData = addresses.firstWhere(
      (addr) => addr["id"].toString() == selectedAddress,
      orElse: () => addresses.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_location),
            onPressed: () {
              // navigateTo(EditAddressView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Delivery Address Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Address",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${selectedAddressData["title"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${selectedAddressData["name"]}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${selectedAddressData["address"]}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${selectedAddressData["city"]}, ${selectedAddressData["state"]} ${selectedAddressData["zipCode"]}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  GestureDetector(
                    onTap: () {
                      _showAddressSelector();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Change Address",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Delivery Time Slots
            Text(
              "Select Delivery Time",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...deliveryTimeSlots.map((slot) {
              final isSelected = selectedTimeSlot == slot["id"].toString();
              final isAvailable = slot["available"] as bool;
              
              return GestureDetector(
                onTap: () {
                  if (isAvailable) {
                    selectedTimeSlot = slot["id"].toString();
                    setState(() {});
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isSelected ? Border.all(
                      color: primaryColor,
                      width: 2,
                    ) : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledBoldColor,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${slot["label"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isAvailable ? Colors.black : disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${slot["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: isAvailable ? disabledBoldColor : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isAvailable)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "UNAVAILABLE",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        )
                      else if ((slot["fee"] as double) > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "+\$${(slot["fee"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "FREE",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),

            // Building Access Information
            Text(
              "Building Access Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Door/Gate Access Code",
                    value: doorAccessCode,
                    hint: "Enter access code",
                    onChanged: (value) {
                      doorAccessCode = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Floor Number",
                    value: buildingFloor,
                    hint: "e.g., 5th Floor",
                    onChanged: (value) {
                      buildingFloor = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QTextField(
              label: "Specific Location",
              value: specificLocation,
              hint: "e.g., Next to elevator, End of hallway",
              onChanged: (value) {
                specificLocation = value;
                setState(() {});
              },
            ),

            // Delivery Instructions
            Text(
              "Delivery Instructions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QMemoField(
              label: "Special Instructions",
              value: deliveryInstructions,
              hint: "Add any special delivery instructions for the driver...",
              onChanged: (value) {
                deliveryInstructions = value;
                setState(() {});
              },
            ),

            // Contact Preferences
            Text(
              "Contact Preferences",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QDropdownField(
              label: "Preferred Contact Method",
              items: contactMethodItems,
              value: contactMethod,
              onChanged: (value, label) {
                contactMethod = value;
                setState(() {});
              },
            ),

            // Options
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Notifications",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Get notified when driver is on the way",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: notifyOnDelivery,
                        onChanged: (value) {
                          notifyOnDelivery = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.save,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Save Instructions",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Remember these instructions for future orders",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: saveInstructions,
                        onChanged: (value) {
                          saveInstructions = value;
                          setState(() {});
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Delivery Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: successColor.withAlpha(80),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Summary",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Text(
                        "Address:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${selectedAddressData["title"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Time:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${deliveryTimeSlots.firstWhere((slot) => slot["id"].toString() == selectedTimeSlot)["time"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Contact:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${contactMethodItems.firstWhere((method) => method["value"] == contactMethod)["label"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  
                  if (deliveryInstructions.isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Text(
                      "Instructions:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      deliveryInstructions,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Confirm Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Confirm Delivery Details",
                size: bs.md,
                icon: Icons.check,
                onPressed: () {
                  _confirmDeliveryDetails();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Delivery Address",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...addresses.map((address) => ListTile(
              leading: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  address["type"] == "home" ? Icons.home : Icons.business,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              title: Text("${address["title"]}"),
              subtitle: Text("${address["address"]}"),
              trailing: Radio<String>(
                value: address["id"].toString(),
                groupValue: selectedAddress,
                onChanged: (value) {
                  selectedAddress = value!;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              onTap: () {
                selectedAddress = address["id"].toString();
                setState(() {});
                Navigator.pop(context);
              },
            )).toList(),
            SizedBox(height: spMd),
            QButton(
              label: "Add New Address",
              size: bs.md,
              icon: Icons.add,
              onPressed: () {
                Navigator.pop(context);
                // navigateTo(AddAddressView());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeliveryDetails() {
    final selectedSlot = deliveryTimeSlots.firstWhere(
      (slot) => slot["id"].toString() == selectedTimeSlot,
    );
    
    final deliveryFee = selectedSlot["fee"] as double;
    
    ss("Delivery details confirmed${deliveryFee > 0 ? ' (Additional fee: \$${deliveryFee.toStringAsFixed(2)})' : ''}");
    
    // Save instructions if enabled
    if (saveInstructions && deliveryInstructions.isNotEmpty) {
      si("Delivery instructions saved for future orders");
    }
    
    // back();
  }
}
