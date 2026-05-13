import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDeliveryAddressView extends StatefulWidget {
  const LtaDeliveryAddressView({super.key});

  @override
  State<LtaDeliveryAddressView> createState() => _LtaDeliveryAddressViewState();
}

class _LtaDeliveryAddressViewState extends State<LtaDeliveryAddressView> {
  String selectedAddress = "";
  String streetAddress = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  String recipientName = "";
  String recipientPhone = "";
  String recipientEmail = "";
  String deliveryInstructions = "";
  String selectedAddressType = "Residential";
  bool saveAsDefault = false;
  bool notifyRecipient = true;
  bool requireSignature = true;

  List<Map<String, dynamic>> addressTypes = [
    {"label": "Residential", "value": "Residential"},
    {"label": "Business", "value": "Business"},
    {"label": "P.O. Box", "value": "P.O. Box"},
    {"label": "Hotel", "value": "Hotel"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
  ];

  List<Map<String, dynamic>> savedAddresses = [
    {
      "id": 1,
      "name": "John's Home",
      "type": "Residential",
      "address": "789 Oak Street",
      "city": "Los Angeles",
      "state": "CA",
      "zipCode": "90210",
      "recipient": "John Doe",
      "phone": "+1 (555) 123-4567",
      "email": "john@email.com",
      "isDefault": true,
      "deliveryCount": 15,
    },
    {
      "id": 2,
      "name": "ABC Corporation",
      "type": "Business",
      "address": "456 Corporate Blvd, Floor 12",
      "city": "Los Angeles",
      "state": "CA",
      "zipCode": "90211",
      "recipient": "Jane Smith",
      "phone": "+1 (555) 987-6543",
      "email": "jane@abccorp.com",
      "isDefault": false,
      "deliveryCount": 8,
    },
    {
      "id": 3,
      "name": "Mom's House",
      "type": "Residential",
      "address": "321 Pine Avenue",
      "city": "San Diego",
      "state": "CA",
      "zipCode": "92101",
      "recipient": "Mary Johnson",
      "phone": "+1 (555) 456-7890",
      "email": "mary@email.com",
      "isDefault": false,
      "deliveryCount": 5,
    },
  ];

  List<Map<String, dynamic>> recentDeliveries = [
    {
      "id": 1,
      "address": "789 Oak Street, Los Angeles, CA 90210",
      "recipient": "John Doe",
      "date": "2024-01-15",
      "status": "Delivered",
    },
    {
      "id": 2,
      "address": "456 Corporate Blvd, Los Angeles, CA 90211",
      "recipient": "Jane Smith",
      "date": "2024-01-12",
      "status": "Delivered",
    },
  ];

  double get estimatedDeliveryDistance {
    // Mock calculation based on selected address
    if (selectedAddress.isNotEmpty) {
      return 12.5; // km
    }
    return 0.0;
  }

  String get estimatedDeliveryTime {
    if (estimatedDeliveryDistance > 0) {
      return "2-3 business days";
    }
    return "N/A";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Address"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Scan address QR code
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //navigateTo('LtaAddressSearchView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Delivery Estimate
            if (estimatedDeliveryDistance > 0) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      color: infoColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Estimated Delivery",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "$estimatedDeliveryTime • ${estimatedDeliveryDistance.toStringAsFixed(1)} km",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Saved Addresses
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Saved Delivery Addresses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...savedAddresses.map((address) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: selectedAddress == "${address["id"]}" 
                            ? primaryColor.withAlpha(20) 
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: selectedAddress == "${address["id"]}" 
                              ? primaryColor 
                              : disabledOutlineBorderColor,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          selectedAddress = "${address["id"]}";
                          streetAddress = "${address["address"]}";
                          city = "${address["city"]}";
                          state = "${address["state"]}";
                          zipCode = "${address["zipCode"]}";
                          recipientName = "${address["recipient"]}";
                          recipientPhone = "${address["phone"]}";
                          recipientEmail = "${address["email"]}";
                          selectedAddressType = "${address["type"]}";
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: selectedAddress == "${address["id"]}" 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  address["type"] == "Residential" ? Icons.home :
                                  address["type"] == "Business" ? Icons.business :
                                  address["type"] == "Hotel" ? Icons.hotel :
                                  Icons.markunread_mailbox,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${address["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (address["isDefault"] as bool) ...[
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: successColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "DEFAULT",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                        Spacer(),
                                        Text(
                                          "${address["deliveryCount"]} deliveries",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${address["address"]}, ${address["city"]}, ${address["state"]} ${address["zipCode"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${address["recipient"]} • ${address["phone"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (selectedAddress == "${address["id"]}") ...[
                                Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Manual Address Entry
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Enter New Delivery Address",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Address Type",
                    items: addressTypes,
                    value: selectedAddressType,
                    onChanged: (value, label) {
                      selectedAddressType = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Street Address",
                    value: streetAddress,
                    hint: "Enter delivery address",
                    onChanged: (value) {
                      streetAddress = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: QTextField(
                          label: "City",
                          value: city,
                          onChanged: (value) {
                            city = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "State",
                          value: state,
                          onChanged: (value) {
                            state = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "ZIP Code",
                          value: zipCode,
                          onChanged: (value) {
                            zipCode = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Country",
                    items: countries,
                    value: country,
                    onChanged: (value, label) {
                      country = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Recipient Information
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Recipient Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Recipient Name",
                    value: recipientName,
                    hint: "Full name of recipient",
                    onChanged: (value) {
                      recipientName = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Phone Number",
                          value: recipientPhone,
                          hint: "Contact number",
                          onChanged: (value) {
                            recipientPhone = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Email Address",
                          value: recipientEmail,
                          hint: "For notifications",
                          onChanged: (value) {
                            recipientEmail = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QMemoField(
                    label: "Delivery Instructions",
                    value: deliveryInstructions,
                    hint: "Special delivery instructions (e.g., leave at door, ring doorbell)",
                    onChanged: (value) {
                      deliveryInstructions = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Delivery Options
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Delivery Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Notify recipient via SMS/Email",
                        "value": true,
                        "checked": notifyRecipient,
                      }
                    ],
                    value: [
                      if (notifyRecipient)
                        {"label": "Notify recipient via SMS/Email", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      notifyRecipient = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Signature required on delivery",
                        "value": true,
                        "checked": requireSignature,
                      }
                    ],
                    value: [
                      if (requireSignature)
                        {"label": "Signature required on delivery", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      requireSignature = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Save as default delivery address",
                        "value": true,
                        "checked": saveAsDefault,
                      }
                    ],
                    value: [
                      if (saveAsDefault)
                        {"label": "Save as default delivery address", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      saveAsDefault = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Recent Deliveries
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Recent Deliveries",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...recentDeliveries.map((delivery) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${delivery["address"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "To: ${delivery["recipient"]} • ${delivery["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Use this address again
                            },
                            child: Icon(
                              Icons.refresh,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Validate Address",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('LtaAddressValidationView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Continue",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('LtaAddressValidationView')
                    },
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
