import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaAddAddressView extends StatefulWidget {
  const SpaAddAddressView({Key? key}) : super(key: key);

  @override
  State<SpaAddAddressView> createState() => _SpaAddAddressViewState();
}

class _SpaAddAddressViewState extends State<SpaAddAddressView> {
  final formKey = GlobalKey<FormState>();
  
  String addressLabel = "";
  String fullName = "";
  String phoneNumber = "";
  String addressLine1 = "";
  String addressLine2 = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  String addressType = "home";
  bool isDefault = false;
  String specialInstructions = "";
  
  // Location coordinates (would be set from map picker)
  double? latitude;
  double? longitude;
  
  List<Map<String, dynamic>> addressTypes = [
    {"label": "Home", "value": "home", "icon": Icons.home},
    {"label": "Work", "value": "work", "icon": Icons.work},
    {"label": "Family", "value": "family", "icon": Icons.family_restroom},
    {"label": "Vacation", "value": "vacation", "icon": Icons.beach_access},
    {"label": "Other", "value": "other", "icon": Icons.location_on},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Italy", "value": "Italy"},
    {"label": "Spain", "value": "Spain"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Address"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              _saveAddress();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Address Label Section
                    _buildFormSection(
                      title: "Address Label",
                      icon: Icons.label,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QTextField(
                            label: "Address Label",
                            value: addressLabel,
                            hint: "e.g., Home, Office, Mom's House",
                            validator: Validator.required,
                            onChanged: (value) {
                              addressLabel = value;
                              setState(() {});
                            },
                          ),
                          Text(
                            "Give this address a memorable name to easily identify it",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Address Type Selection
                    _buildFormSection(
                      title: "Address Type",
                      icon: Icons.category,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QCategoryPicker(
                            items: addressTypes.map((type) => {
                              "label": type["label"],
                              "value": type["value"],
                            }).toList(),
                            value: addressType,
                            onChanged: (index, label, value, item) {
                              addressType = value;
                              setState(() {});
                            },
                          ),
                          if (addressType.isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getAddressTypeColor(addressType).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _getAddressTypeIcon(addressType),
                                    color: _getAddressTypeColor(addressType),
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Selected: ${addressTypes.firstWhere((t) => t["value"] == addressType)["label"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _getAddressTypeColor(addressType),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Contact Information
                    _buildFormSection(
                      title: "Contact Information",
                      icon: Icons.person,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QTextField(
                            label: "Full Name",
                            value: fullName,
                            hint: "Recipient name for deliveries",
                            validator: Validator.required,
                            onChanged: (value) {
                              fullName = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Phone Number",
                            value: phoneNumber,
                            hint: "+1 (555) 123-4567",
                            validator: Validator.required,
                            onChanged: (value) {
                              phoneNumber = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Address Details
                    _buildFormSection(
                      title: "Address Details",
                      icon: Icons.location_on,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QTextField(
                            label: "Street Address",
                            value: addressLine1,
                            hint: "123 Main Street",
                            validator: Validator.required,
                            onChanged: (value) {
                              addressLine1 = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Apartment, Suite, etc. (Optional)",
                            value: addressLine2,
                            hint: "Apt 4B, Suite 200",
                            onChanged: (value) {
                              addressLine2 = value;
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
                                  hint: "New York",
                                  validator: Validator.required,
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
                                  hint: "NY",
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    state = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: QTextField(
                                  label: "ZIP Code",
                                  value: zipCode,
                                  hint: "10001",
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    zipCode = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                flex: 2,
                                child: QDropdownField(
                                  label: "Country",
                                  items: countries,
                                  value: country,
                                  onChanged: (value, label) {
                                    country = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Map Location (Optional)
                    _buildFormSection(
                      title: "Location on Map",
                      icon: Icons.map,
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.map,
                                    size: 48,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "Tap to select location on map",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  QButton(
                                    label: "Select on Map",
                                    size: bs.sm,
                                    icon: Icons.location_searching,
                                    onPressed: () {
                                      _selectLocationOnMap();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (latitude != null && longitude != null)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "Location selected: ${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Special Instructions
                    _buildFormSection(
                      title: "Special Instructions",
                      icon: Icons.info,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QMemoField(
                            label: "Delivery Instructions",
                            value: specialInstructions,
                            hint: "e.g., Ring doorbell twice, Leave at front door, Ask for Sarah at reception...",
                            onChanged: (value) {
                              specialInstructions = value;
                              setState(() {});
                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Helpful instruction examples:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                _buildInstructionExample("Ring doorbell twice"),
                                _buildInstructionExample("Use back entrance"),
                                _buildInstructionExample("Call when you arrive"),
                                _buildInstructionExample("Leave with concierge"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Address Settings
                    _buildFormSection(
                      title: "Address Settings",
                      icon: Icons.settings,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QSwitch(
                            items: [
                              {
                                "label": "Set as default address",
                                "value": "default",
                                "checked": isDefault,
                              }
                            ],
                            value: isDefault
                                ? [
                                    {
                                      "label": "Set as default address",
                                      "value": "default",
                                      "checked": true,
                                    }
                                  ]
                                : [],
                            onChanged: (values, ids) {
                              isDefault = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          if (isDefault)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "This address will be used as your default delivery location",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Preview Section
                    if (addressLabel.isNotEmpty && fullName.isNotEmpty && addressLine1.isNotEmpty)
                      _buildAddressPreview(),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.md,
                      color: secondaryColor,
                      onPressed: () {
                        _showCancelDialog();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Save Address",
                      size: bs.md,
                      onPressed: () {
                        _saveAddress();
                      },
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

  Widget _buildFormSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionExample(String instruction) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Icon(
            Icons.arrow_right,
            color: disabledBoldColor,
            size: 14,
          ),
          SizedBox(width: spXs),
          Text(
            instruction,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressPreview() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.preview,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Address Preview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      _getAddressTypeIcon(addressType),
                      color: _getAddressTypeColor(addressType),
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      addressLabel,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isDefault) ...[
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
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
                  fullName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  addressLine1 + (addressLine2.isNotEmpty ? ", $addressLine2" : ""),
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "$city, $state $zipCode",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  country,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (specialInstructions.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            specialInstructions,
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
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

  IconData _getAddressTypeIcon(String type) {
    switch (type) {
      case "home":
        return Icons.home;
      case "work":
        return Icons.work;
      case "family":
        return Icons.family_restroom;
      case "vacation":
        return Icons.beach_access;
      default:
        return Icons.location_on;
    }
  }

  Color _getAddressTypeColor(String type) {
    switch (type) {
      case "home":
        return primaryColor;
      case "work":
        return infoColor;
      case "family":
        return successColor;
      case "vacation":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _selectLocationOnMap() {
    // Simulate location selection
    latitude = 40.7128 + (1.0 - 2.0) * 0.01; // Random around NYC
    longitude = -74.0060 + (1.0 - 2.0) * 0.01;
    setState(() {});
    si("Location selected on map");
  }

  void _showCancelDialog() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel? Your changes will be lost.");
    if (isConfirmed) {
      back();
    }
  }

  void _saveAddress() {
    if (formKey.currentState!.validate()) {
      // Save address logic here
      ss("Address saved successfully!");
      back();
    } else {
      se("Please fill in all required fields");
    }
  }
}
