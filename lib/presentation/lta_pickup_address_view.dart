import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPickupAddressView extends StatefulWidget {
  const LtaPickupAddressView({super.key});

  @override
  State<LtaPickupAddressView> createState() => _LtaPickupAddressViewState();
}

class _LtaPickupAddressViewState extends State<LtaPickupAddressView> {
  String selectedAddress = "";
  String streetAddress = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  String contactName = "";
  String contactPhone = "";
  String pickupInstructions = "";
  String selectedAddressType = "Home";
  bool saveAsDefault = false;

  List<Map<String, dynamic>> addressTypes = [
    {"label": "Home", "value": "Home"},
    {"label": "Office", "value": "Office"},
    {"label": "Warehouse", "value": "Warehouse"},
    {"label": "Store", "value": "Store"},
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
      "name": "Home Address",
      "type": "Home",
      "address": "123 Main Street",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "contact": "John Doe",
      "phone": "+1 (555) 123-4567",
      "isDefault": true,
      "lastUsed": "2024-01-15",
    },
    {
      "id": 2,
      "name": "Office Address",
      "type": "Office",
      "address": "456 Business Ave, Suite 200",
      "city": "New York",
      "state": "NY",
      "zipCode": "10002",
      "contact": "Jane Smith",
      "phone": "+1 (555) 987-6543",
      "isDefault": false,
      "lastUsed": "2024-01-12",
    },
    {
      "id": 3,
      "name": "Warehouse",
      "type": "Warehouse",
      "address": "789 Industrial Blvd",
      "city": "Brooklyn",
      "state": "NY",
      "zipCode": "11201",
      "contact": "Mike Johnson",
      "phone": "+1 (555) 456-7890",
      "isDefault": false,
      "lastUsed": "2024-01-10",
    },
  ];

  List<Map<String, dynamic>> recentPickups = [
    {
      "id": 1,
      "address": "123 Main Street, New York, NY 10001",
      "date": "2024-01-15",
      "time": "10:30 AM",
      "status": "Completed",
    },
    {
      "id": 2,
      "address": "456 Business Ave, New York, NY 10002",
      "date": "2024-01-12",
      "time": "2:15 PM",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup Address"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              // Use current location
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
                    "Saved Addresses",
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
                          contactName = "${address["contact"]}";
                          contactPhone = "${address["phone"]}";
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
                                  address["type"] == "Home" ? Icons.home :
                                  address["type"] == "Office" ? Icons.business :
                                  address["type"] == "Warehouse" ? Icons.warehouse :
                                  Icons.location_on,
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
                                      "${address["contact"]} • ${address["phone"]}",
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
                    "Enter New Address",
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
                    hint: "Enter street address",
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

            // Contact Information
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
                    "Contact Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Contact Name",
                    value: contactName,
                    hint: "Person available for pickup",
                    onChanged: (value) {
                      contactName = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Contact Phone",
                    value: contactPhone,
                    hint: "Phone number for pickup contact",
                    onChanged: (value) {
                      contactPhone = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Pickup Instructions",
                    value: pickupInstructions,
                    hint: "Special instructions for pickup (e.g., gate code, building access)",
                    onChanged: (value) {
                      pickupInstructions = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Recent Pickups
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
                    "Recent Pickups",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...recentPickups.map((pickup) {
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
                                  "${pickup["address"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${pickup["date"]} at ${pickup["time"]}",
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

            // Save Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: QSwitch(
                items: [
                  {
                    "label": "Save as default pickup address",
                    "value": true,
                    "checked": saveAsDefault,
                  }
                ],
                value: [
                  if (saveAsDefault)
                    {"label": "Save as default pickup address", "value": true, "checked": true}
                ],
                onChanged: (values, ids) {
                  saveAsDefault = values.isNotEmpty;
                  setState(() {});
                },
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
                      //navigateTo('LtaDeliveryAddressView')
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
