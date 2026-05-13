import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaProofDeliveryView extends StatefulWidget {
  const LtaProofDeliveryView({super.key});

  @override
  State<LtaProofDeliveryView> createState() => _LtaProofDeliveryViewState();
}

class _LtaProofDeliveryViewState extends State<LtaProofDeliveryView> {
  String selectedOrderId = "";
  String customerName = "";
  String deliveryAddress = "";
  String recipientName = "";
  String recipientPhone = "";
  String deliveryNotes = "";
  String customerSignature = "";
  List<String> deliveryPhotos = [];
  String geolocation = "";
  DateTime deliveryTime = DateTime.now();
  bool proofOfDelivery = false;
  bool customerPresent = true;

  List<Map<String, dynamic>> orderData = [
    {
      "order_id": "ORD-2024-001",
      "customer_name": "John Smith",
      "delivery_address": "123 Main Street, Springfield, IL 62701",
      "phone": "+1 555-0123",
      "items": ["iPhone 15 Pro", "AirPods Pro", "Lightning Cable"],
      "total_amount": 1299.97,
      "delivery_date": "2024-06-15",
      "status": "Out for Delivery",
    },
    {
      "order_id": "ORD-2024-002",
      "customer_name": "Sarah Johnson",
      "delivery_address": "456 Oak Avenue, Springfield, IL 62702",
      "phone": "+1 555-0456",
      "items": ["Samsung Galaxy S24", "Galaxy Buds", "Wireless Charger"],
      "total_amount": 999.97,
      "delivery_date": "2024-06-15",
      "status": "Out for Delivery",
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() {
    // Simulate getting current location
    geolocation = "39.7817° N, 89.6501° W";
    setState(() {});
  }

  void _submitProofOfDelivery() async {
    if (selectedOrderId.isEmpty) {
      se("Please select an order");
      return;
    }

    if (deliveryPhotos.isEmpty) {
      se("Please take at least one delivery photo");
      return;
    }

    if (recipientName.isEmpty) {
      se("Please enter recipient name");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    ss("Proof of delivery submitted successfully");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proof of Delivery"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              si("Proof of delivery help information");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Order Selection
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Order Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Select Order",
                    items: orderData.map((order) => {
                      "label": "${order["order_id"]} - ${order["customer_name"]}",
                      "value": order["order_id"],
                    }).toList(),
                    value: selectedOrderId,
                    onChanged: (value, label) {
                      selectedOrderId = value;
                      final selectedOrder = orderData.firstWhere(
                        (order) => order["order_id"] == value,
                      );
                      customerName = selectedOrder["customer_name"] as String;
                      deliveryAddress = selectedOrder["delivery_address"] as String;
                      setState(() {});
                    },
                  ),
                  if (selectedOrderId.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Customer: $customerName",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Address: $deliveryAddress",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Items: ${(orderData.firstWhere((order) => order["order_id"] == selectedOrderId)["items"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Delivery Photos
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Delivery Photos",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "*Required",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  QMultiImagePicker(
                    label: "Take Delivery Photos",
                    value: deliveryPhotos,
                    maxImages: 5,
                    hint: "Take photos of the delivered package",
                    validator: (images) {
                      if (images == null || images.isEmpty) {
                        return "At least one photo is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      deliveryPhotos = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Customer Presence and Recipient Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Recipient Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Customer was present",
                        "value": true,
                        "checked": customerPresent,
                      }
                    ],
                    value: [if (customerPresent) {"label": "Customer was present", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      customerPresent = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Recipient Name",
                    value: recipientName,
                    hint: "Enter the name of person who received the package",
                    validator: Validator.required,
                    onChanged: (value) {
                      recipientName = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Recipient Phone (Optional)",
                    value: recipientPhone,
                    hint: "Enter recipient's phone number",
                    onChanged: (value) {
                      recipientPhone = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Delivery Details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Delivery Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDatePicker(
                    label: 'Delivery Date',
                    value: deliveryTime,
                    onChanged: (value) {
                      deliveryTime = value;
                      setState(() {});
                    },
                  ),
                  QTimePicker(
                    label: 'Delivery Time',
                    value: TimeOfDay.fromDateTime(deliveryTime),
                    onChanged: (value) {
                      if (value != null) {
                        deliveryTime = DateTime(
                          deliveryTime.year,
                          deliveryTime.month,
                          deliveryTime.day,
                          value.hour,
                          value.minute,
                        );
                        setState(() {});
                      }
                    },
                  ),
                  QMemoField(
                    label: "Delivery Notes",
                    value: deliveryNotes,
                    hint: "Add any special notes about the delivery",
                    onChanged: (value) {
                      deliveryNotes = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Location Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Location Verification",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: successColor.withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.gps_fixed,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Current Location",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          geolocation,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Location captured automatically",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Digital Signature
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.draw,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Customer Signature (Optional)",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QImagePicker(
                    label: "Customer Signature",
                    value: customerSignature,
                    hint: "Capture customer signature",
                    onChanged: (value) {
                      customerSignature = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Confirmation
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "I confirm this delivery is complete and accurate",
                        "value": true,
                        "checked": proofOfDelivery,
                      }
                    ],
                    value: [if (proofOfDelivery) {"label": "I confirm this delivery is complete and accurate", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      proofOfDelivery = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Submit Proof of Delivery",
                      size: bs.md,
                      onPressed: _submitProofOfDelivery,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
